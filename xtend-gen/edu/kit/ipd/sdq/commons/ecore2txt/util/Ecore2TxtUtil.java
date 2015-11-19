package edu.kit.ipd.sdq.commons.ecore2txt.util;

import com.google.inject.Guice;
import com.google.inject.Injector;
import com.google.inject.Module;
import edu.kit.ipd.sdq.vitruvius.framework.util.bridges.EMFBridge;
import edu.kit.ipd.sdq.vitruvius.framework.util.bridges.EclipseBridge;
import edu.kit.ipd.sdq.vitruvius.framework.util.bridges.EcoreResourceBridge;
import org.eclipse.core.resources.IFile;
import org.eclipse.core.resources.IFolder;
import org.eclipse.core.resources.IProject;
import org.eclipse.emf.common.util.URI;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.emf.ecore.resource.impl.ResourceSetImpl;
import org.eclipse.xtext.generator.IFileSystemAccess;
import org.eclipse.xtext.generator.IGenerator;
import org.eclipse.xtext.generator.JavaIoFileSystemAccess;

/**
 * A utility class for generating code from Ecore-based models triggered by an entry in the Eclipse navigator.
 */
@SuppressWarnings("all")
public class Ecore2TxtUtil {
  /**
   * Utility classes should not have a public or default constructor.
   */
  private Ecore2TxtUtil() {
  }
  
  public static void generateFromSelectedFilesInFolder(final Iterable<IFile> files, final Module generatorModule, final IGenerator generator, final String genTargetFolderName) {
    for (final IFile file : files) {
      {
        final IProject project = file.getProject();
        final IFolder genTargetFolder = EMFBridge.createFolderInProjectIfNecessary(project, genTargetFolderName);
        final JavaIoFileSystemAccess fsa = new JavaIoFileSystemAccess();
        Injector _createInjector = Guice.createInjector(generatorModule);
        _createInjector.injectMembers(fsa);
        final String absoluteGenFolderPath = EclipseBridge.getAbsolutePathString(genTargetFolder);
        fsa.setOutputPath(absoluteGenFolderPath);
        final URI uri = EMFBridge.getEMFPlatformUriForIResource(file);
        Ecore2TxtUtil.generateFromResourceAtURI(uri, fsa, generator);
      }
    }
  }
  
  public static void generateFromResourceAtURI(final URI uri, final IFileSystemAccess fsa, final IGenerator generator) {
    final ResourceSetImpl resourceSet = new ResourceSetImpl();
    final Resource resource = EcoreResourceBridge.loadResourceAtURI(uri, resourceSet);
    generator.doGenerate(resource, fsa);
  }
}
