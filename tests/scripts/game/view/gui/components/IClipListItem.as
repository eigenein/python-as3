package game.view.gui.components
{
   import engine.core.clipgui.IGuiClip;
   import idv.cjcat.signals.Signal;
   
   public interface IClipListItem extends IGuiClip
   {
       
      
      function dispose() : void;
      
      function get signal_select() : Signal;
      
      function setData(param1:*) : void;
      
      function setSelected(param1:Boolean) : void;
   }
}
