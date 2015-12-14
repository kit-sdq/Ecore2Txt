package edu.kit.ipd.sdq.commons.ecore2txt.generator

import edu.kit.ipd.sdq.vitruvius.framework.util.bridges.EMFBridge
import edu.kit.ipd.sdq.vitruvius.framework.util.bridges.EcoreResourceBridge
import org.eclipse.core.resources.IFile
import org.eclipse.emf.ecore.resource.impl.ResourceSetImpl
import edu.kit.ipd.sdq.vitruvius.framework.util.datatypes.Quadruple
import edu.kit.ipd.sdq.vitruvius.framework.util.datatypes.Pair
import org.eclipse.core.resources.IProject
import java.util.ArrayList
import org.eclipse.emf.ecore.resource.Resource

abstract class AbstractEcore2TxtGenerator implements Ecore2TxtGenerator {
	
	override generateContentsForFolderAndFileNamesInProject(Iterable<IFile> inputFiles) {			
		val resourceSet = new ResourceSetImpl()
		val results = new ArrayList<Quadruple<String,String,String,IProject>>()
		for (inputFile : inputFiles) {
			val inputURI = EMFBridge.getEMFPlatformUriForIResource(inputFile)
			val inputResource = EcoreResourceBridge.loadResourceAtURI(inputURI, resourceSet)
			val folderName = getFolderNameForResource(inputResource)
			val project = getProjectForFile(inputFile)
			val contentsAndFileNames = generateContentsFromResource(inputResource)
			for (contentAndFileName : contentsAndFileNames) {
				val content = contentAndFileName.first
				val fileName = contentAndFileName.second
				val result = new Quadruple<String,String,String,IProject>(content, folderName, fileName, project)
				results.add(result)
			}
		}
		return results
	}
	
	/**
	 * @return an iterable of pairs of generated contents and file names
	 */
	def abstract Iterable<Pair<String,String>> generateContentsFromResource(Resource inputResource)
	
	def abstract String getFolderNameForResource(Resource inputResource)
	
	def abstract String getFileNameForResource(Resource inputResource)
	
	def IProject getProjectForFile(IFile inputFile) {
		return inputFile.getProject()
	}
}