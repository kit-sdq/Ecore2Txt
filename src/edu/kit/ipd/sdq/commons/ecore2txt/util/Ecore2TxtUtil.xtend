package edu.kit.ipd.sdq.commons.ecore2txt.util

import com.google.inject.Guice
import com.google.inject.Module
import edu.kit.ipd.sdq.vitruvius.framework.util.bridges.EMFBridge
import edu.kit.ipd.sdq.vitruvius.framework.util.bridges.EclipseBridge
import edu.kit.ipd.sdq.vitruvius.framework.util.bridges.EcoreResourceBridge
import org.eclipse.core.resources.IFile
import org.eclipse.emf.common.util.URI
import org.eclipse.emf.ecore.resource.impl.ResourceSetImpl
import org.eclipse.xtext.generator.IFileSystemAccess
import org.eclipse.xtext.generator.IGenerator
import org.eclipse.xtext.generator.JavaIoFileSystemAccess

/**
 * A utility class for generating code from Ecore-based models triggered by an entry in the Eclipse navigator.
 */
class Ecore2TxtUtil {
	
	/** Utility classes should not have a public or default constructor. */
	private new() {
		// empty
	}
	
	def static void generateFromSelectedFilesInFolder(Iterable<IFile> files, Module generatorModule, IGenerator generator, String genTargetFolderName) {
		for (IFile file : files) {
			val project = file.getProject()
			val genTargetFolder = EMFBridge.createFolderInProjectIfNecessary(project, genTargetFolderName)
			val fsa = new JavaIoFileSystemAccess()
			// without this injection the fsa would not provide the encoding
			Guice.createInjector(generatorModule).injectMembers(fsa)
			val absoluteGenFolderPath = EclipseBridge.getAbsolutePathString(genTargetFolder)
			fsa.setOutputPath(absoluteGenFolderPath)
			val uri = EMFBridge.getEMFPlatformUriForIResource(file)
			generateFromResourceAtURI(uri, fsa, generator)
		}
	}

	def static void generateFromResourceAtURI(URI uri, IFileSystemAccess fsa, IGenerator generator) {
		val resourceSet = new ResourceSetImpl()
		val resource = EcoreResourceBridge.loadResourceAtURI(uri, resourceSet)
		generator.doGenerate(resource, fsa)
	}
}