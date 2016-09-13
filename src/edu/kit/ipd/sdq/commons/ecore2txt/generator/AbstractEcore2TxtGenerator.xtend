package edu.kit.ipd.sdq.commons.ecore2txt.generator

import tools.vitruv.framework.util.bridges.EMFBridge
import tools.vitruv.framework.util.bridges.EcoreResourceBridge
import tools.vitruv.framework.util.datatypes.Quadruple
import java.util.ArrayList
import org.eclipse.core.resources.IFile
import org.eclipse.core.resources.IProject
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.emf.ecore.resource.impl.ResourceSetImpl
import java.util.List
import org.eclipse.internal.xtend.util.Triplet

abstract class AbstractEcore2TxtGenerator implements Ecore2TxtGenerator {
	
	override generateContentsForFolderAndFileNamesInProject(List<IFile> inputFiles) {			
		val resourceSet = new ResourceSetImpl()
		val results = new ArrayList<Quadruple<String,String,String,IProject>>()
		val preprocessedInputFiles = preprocessInputFiles(inputFiles)
		for (inputFile : preprocessedInputFiles) {
			val inputURI = EMFBridge.getEMFPlatformUriForIResource(inputFile)
			val inputResource = EcoreResourceBridge.loadResourceAtURI(inputURI, resourceSet)
			val project = getProjectForFile(inputFile)
			val contentsForFolderAndFileNames = generateContentsFromResource(inputResource)
			for (contentForFolderAndFileName : contentsForFolderAndFileNames) {
				val content = contentForFolderAndFileName.first
				val folderName = contentForFolderAndFileName.second
				val fileName = contentForFolderAndFileName.third
				val result = new Quadruple<String,String,String,IProject>(content, folderName, fileName, project)
				results.add(result)
			}
		}
		return results
	}
	
	def List<IFile> preprocessInputFiles(List<IFile> inputFiles) {
		// do nothing
		return inputFiles
	}
	
	/**
	 * @return an iterable of pairs of generated contents and file names
	 */
	def abstract Iterable<Triplet<String,String,String>> generateContentsFromResource(Resource inputResource)
	
	def abstract String getFolderNameForResource(Resource inputResource)
	
	def abstract String getFileNameForResource(Resource inputResource)
	
	def IProject getProjectForFile(IFile inputFile) {
		return inputFile.getProject()
	}
}