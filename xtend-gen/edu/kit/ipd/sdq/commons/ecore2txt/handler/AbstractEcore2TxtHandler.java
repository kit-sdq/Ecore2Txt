package edu.kit.ipd.sdq.commons.ecore2txt.handler;

import com.google.common.collect.Iterables;
import java.util.List;
import org.eclipse.core.commands.AbstractHandler;
import org.eclipse.core.commands.ExecutionEvent;
import org.eclipse.core.commands.ExecutionException;
import org.eclipse.core.commands.IHandler;
import org.eclipse.core.resources.IFile;
import org.eclipse.jface.viewers.ISelection;
import org.eclipse.jface.viewers.IStructuredSelection;
import org.eclipse.ui.handlers.HandlerUtil;
import org.eclipse.xtext.xbase.lib.IterableExtensions;

@SuppressWarnings("all")
public abstract class AbstractEcore2TxtHandler extends AbstractHandler implements IHandler {
  @Override
  public Object execute(final ExecutionEvent event) throws ExecutionException {
    final ISelection selection = HandlerUtil.getCurrentSelection(event);
    if ((selection instanceof IStructuredSelection)) {
      final IStructuredSelection structuredSelection = ((IStructuredSelection) selection);
      List _list = structuredSelection.toList();
      final Iterable<IFile> files = Iterables.<IFile>filter(_list, IFile.class);
      int _size = IterableExtensions.size(files);
      boolean _greaterThan = (_size > 0);
      if (_greaterThan) {
        this.executeEcore2TxtGenerator(files);
      }
      return null;
    } else {
      return null;
    }
  }
  
  @Override
  public boolean isEnabled() {
    return true;
  }
  
  public abstract void executeEcore2TxtGenerator(final Iterable<IFile> files);
}
