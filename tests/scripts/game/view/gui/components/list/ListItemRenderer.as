package game.view.gui.components.list
{
   import feathers.controls.List;
   import feathers.controls.renderers.LayoutGroupListItemRenderer;
   
   public class ListItemRenderer extends LayoutGroupListItemRenderer
   {
      
      public static const EVENT_SELECT:String = "ListItemRenderer.EVENT_SELECT";
      
      public static const EVENT_ADD:String = "ListItemRenderer.EVENT_ADD";
      
      public static const EVENT_REMOVE:String = "ListItemRenderer.EVENT_REMOVE";
       
      
      public function ListItemRenderer()
      {
         super();
      }
      
      public function dispatchDataEvent(param1:String) : void
      {
         var _loc2_:List = this.owner;
         if(_loc2_ != null)
         {
            _loc2_.dispatchEventWith(param1,true,data);
         }
      }
   }
}
