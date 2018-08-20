package game.view.gui.components
{
   import flash.geom.Rectangle;
   import idv.cjcat.signals.Signal;
   
   public class ClipButtonListItem extends DataClipButton implements IClipListItem, IClipListItemCustomBounds
   {
       
      
      public function ClipButtonListItem(param1:Object)
      {
         super(param1);
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
