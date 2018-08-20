package game.view.popup.reward.multi
{
   import com.progrestar.framework.ares.core.Node;
   import game.model.user.inventory.InventoryItem;
   import starling.events.Event;
   
   public class InventoryItemFlyingRenderer extends InventoryItemRenderer
   {
       
      
      private var _pushTime:Number = 0;
      
      private var _maxPushTime:Number = 0.3;
      
      protected var _x0:Number;
      
      protected var _y0:Number;
      
      private var _data:InventoryItem;
      
      public function InventoryItemFlyingRenderer()
      {
         super();
      }
      
      public function get data() : InventoryItem
      {
         return _data;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         _x0 = graphics.x;
         _y0 = graphics.y;
      }
      
      public function push() : void
      {
         _pushTime = _maxPushTime;
      }
      
      override public function setData(param1:*) : void
      {
         _data = param1 as InventoryItem;
         super.setData(param1);
      }
      
      private function handler_enterFrame(param1:Event) : void
      {
         _pushTime = _pushTime - param1.data;
         if(_pushTime <= 0)
         {
            _pushTime = 0;
            graphics.removeEventListener("enterFrame",handler_enterFrame);
         }
         var _loc2_:Number = _pushTime / _maxPushTime;
         var _loc3_:* = 1 + _loc2_ * _loc2_ * _loc2_ * 0.2;
         graphics.scaleY = _loc3_;
         graphics.scaleX = _loc3_;
         graphics.x = _x0 - (graphics.scaleX - 1) * 40;
         graphics.y = _y0 - (graphics.scaleY - 1) * 40;
      }
   }
}
