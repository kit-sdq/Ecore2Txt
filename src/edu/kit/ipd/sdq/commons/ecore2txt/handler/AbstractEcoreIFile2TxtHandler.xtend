package edu.kit.ipd.sdq.commons.ecore2txt.handler

import org.eclipse.core.resources.IFile
import org.eclipse.jface.viewers.ISelection
import org.eclipse.jface.viewers.IStructuredSelection
import java.util.Collections

public abstract class AbstractEcoreIFile2TxtHandler extends AbstractEcore2TxtHandler<IFile> {
	
	override Iterable<IFile> filterSelection(ISelection selection) {
		if (selection instanceof IStructuredSelection) {
			val structuredSelection = selection as IStructuredSelection
			val files = structuredSelection.toList.filter(typeof(IFile))
			if (files.size > 0) {
				return files
			}
		}
		return Collections.emptyList()
	}
}