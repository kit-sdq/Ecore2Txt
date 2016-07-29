package edu.kit.ipd.sdq.commons.ecore2txt.generator

import edu.kit.ipd.sdq.vitruvius.framework.util.datatypes.Quadruple
import org.eclipse.core.resources.IFile
import org.eclipse.core.resources.IProject
import java.util.List

interface Ecore2TxtGenerator {

	/**
	 * @return an iterable of quadruples that bundle a content string that should be generated together with a folder name, a file name, and a project to specify where the content shall be put 
	 */
	def Iterable<Quadruple<String,String,String,IProject>> generateContentsForFolderAndFileNamesInProject(List<IFile> inputFiles)
	
	def String postProcessGeneratedContents(String contents)
}