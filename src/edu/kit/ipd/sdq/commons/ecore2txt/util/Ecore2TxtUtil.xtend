/*******************************************************************************
 * Copyright (c) 2015 Software Design and Quality (SDQ) research group
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors:
 *    M. Kramer - initial API and implementation
 *******************************************************************************/
 package edu.kit.ipd.sdq.commons.ecore2txt.util

import com.google.inject.Guice
import com.google.inject.Module
import edu.kit.ipd.sdq.commons.ecore2txt.generator.Ecore2TxtGenerator
import edu.kit.ipd.sdq.vitruvius.framework.util.bridges.EMFBridge
import edu.kit.ipd.sdq.vitruvius.framework.util.bridges.EclipseBridge
import edu.kit.ipd.sdq.vitruvius.framework.util.datatypes.Quadruple
import org.eclipse.core.resources.IFile
import org.eclipse.core.resources.IProject
import org.eclipse.xtext.generator.JavaIoFileSystemAccess

/**
 * A utility class for generating code from Ecore-based models triggered by an entry in the Eclipse navigator.
 */
class Ecore2TxtUtil {
	
	/** Utility classes should not have a public or default constructor. */
	private new() {
		// empty
	}
	
	def static void generateFromSelectedFilesInFolder(Iterable<IFile> inputFiles, Module generatorModule, Ecore2TxtGenerator generator, boolean concatOutputToSingleFile, boolean postProcessContents) {
		val fsa = createAndInjectFileSystemAccessIntoGeneratorModule(generatorModule)
		var contentsForFolderAndFileNames = generator.generateContentsForFolderAndFileNamesInProject(inputFiles)
		if (concatOutputToSingleFile) {
			contentsForFolderAndFileNames = concatOutputToFirstFile(contentsForFolderAndFileNames, generator, postProcessContents)
		}
		outputToFolderFileNameAndProject(contentsForFolderAndFileNames, fsa)
	}
	
	def static JavaIoFileSystemAccess createAndInjectFileSystemAccessIntoGeneratorModule(Module generatorModule) {
		val fsa = new JavaIoFileSystemAccess()
		// without this injection the fsa would not provide the encoding
		Guice.createInjector(generatorModule).injectMembers(fsa)
		return fsa
	}
	
	def static Iterable<Quadruple<String,String,String,IProject>> concatOutputToFirstFile(Iterable<Quadruple<String,String,String,IProject>> contentsForFolderAndFileNames, Ecore2TxtGenerator generator, boolean postProcessContents) {
		val iterator = contentsForFolderAndFileNames.iterator
		if (iterator.hasNext) {
			val contentForFolderAndFileName = iterator.next
			val folderName = contentForFolderAndFileName.second
			val fileName = contentForFolderAndFileName.third
			val project = contentForFolderAndFileName.fourth
			val contentBuilder = new StringBuilder()
			contentsForFolderAndFileNames.forEach[contentBuilder.append(it.first)]
			var contents = contentBuilder.toString
			if (postProcessContents) {
				contents = generator.postProcessGeneratedContents(contents)
			}
			return #[new Quadruple<String,String,String,IProject>(contents, folderName, fileName, project)]
		} else {
			throw new IllegalArgumentException("Cannot concat the empty output '" + contentsForFolderAndFileNames + "'!")
		}
	}

	def static void outputToFolderFileNameAndProject(Iterable<Quadruple<String,String,String,IProject>> contentsForFolderAndFileNames, JavaIoFileSystemAccess fsa) {
		for (contentForFolderAndFileName : contentsForFolderAndFileNames) {
			val content = contentForFolderAndFileName.first
			val folderName = contentForFolderAndFileName.second
			val fileName = contentForFolderAndFileName.third
			val project = contentForFolderAndFileName.fourth
			val genTargetFolder = EMFBridge.createFolderInProjectIfNecessary(project, folderName)
			val absoluteGenFolderPath = EclipseBridge.getAbsolutePathString(genTargetFolder)
			fsa.setOutputPath(absoluteGenFolderPath)
			fsa.generateFile(fileName, content)
		}
	}
}