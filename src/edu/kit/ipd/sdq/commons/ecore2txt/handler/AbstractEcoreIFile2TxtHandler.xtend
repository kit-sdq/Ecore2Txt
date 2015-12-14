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