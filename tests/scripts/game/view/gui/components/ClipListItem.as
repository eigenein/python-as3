package game.view.gui.components
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import flash.geom.Rectangle;
   import idv.cjcat.signals.Signal;
   
   public class ClipListItem extends GuiClipNestedContainer implements IClipListItem, IClipListItemCustomBounds
   {
       
      
      public function ClipListItem()
      {
         super();
      }
      
      public function dispose() : void
      {
      }
      
      public function get signal_select() : Signal
      {
         return null;
      }
      
      public function get customBounds() : Rectangle
      {
         return _container.bounds;
      }
      
      public function setData(param1:*) : void
      {
      }
      
      public function setSelected(param1:Boolean) : void
      {
      }
   }
}
