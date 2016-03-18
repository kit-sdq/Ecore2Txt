package edu.kit.ipd.sdq.commons.ecore2txt.generator

import edu.kit.ipd.sdq.vitruvius.framework.util.bridges.EMFBridge
import edu.kit.ipd.sdq.vitruvius.framework.util.bridges.EcoreResourceBridge
import edu.kit.ipd.sdq.vitruvius.framework.util.datatypes.Quadruple
import edu.kit.ipd.sdq.vitruvius.framework.util.datatypes.Triple
import java.util.ArrayList
import org.eclipse.core.resources.IFile
import org.eclipse.core.resources.IProject
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.emf.ecore.resource.impl.ResourceSetImpl

abstract class AbstractEcore2TxtGenerator implements Ecore2TxtGenerator {
	
	override generateContentsForFolderAndFileNamesInProject(Iterable<IFile> inputFiles) {			
		val resourceSet = new ResourceSetImpl()
		val results = new ArrayList<Quadruple<String,String,String,IProject>>()
		for (inputFile : inputFiles) {
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
	
	/**
	 * @return an iterable of pairs of generated contents and file names
	 */
	def abstract Iterable<Triple<String,String,String>> generateContentsFromResource(Resource inputResource)
	
	def abstract String getFolderNameForResource(Resource inputResource)
	
	def abstract String getFileNameForResource(Resource inputResource)
	
	def IProject getProjectForFile(IFile inputFile) {
		return inputFile.getProject()
	}
}