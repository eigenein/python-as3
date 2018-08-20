package game.view.popup.tower
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mediator.gui.popup.tower.TowerBuffValueObject;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.refillable.CostButton;
   import starling.core.Starling;
   
   public class TowerBuffPanelClip extends GuiClipNestedContainer
   {
       
      
      private var data:TowerBuffValueObject;
      
      public var tf_bought:ClipLabel;
      
      public var tf_name:ClipLabel;
      
      public var tf_desc:ClipLabel;
      
      public var button_buy:CostButton;
      
      public var image_icon:GuiClipImage;
      
      public function TowerBuffPanelClip()
      {
         super();
      }
      
      public function dispose() : void
      {
         if(button_buy)
         {
            button_buy.signal_click.clear();
         }
         if(data)
         {
            unsubscribe();
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_bought.text = Translate.translate("UI_SHOP_SLOT_BOUGHT");
      }
      
      public function setData(param1:TowerBuffValueObject) : void
      {
         if(this.data)
         {
            unsubscribe();
         }
         this.data = param1;
         subscribe();
         image_icon.image.texture = param1.icon;
         button_buy.signal_click.add(handler_click);
         button_buy.cost = param1.cost;
         handler_updated();
      }
      
      public function animate(param1:int) : void
      {
         var _loc2_:Number = graphics.x;
         var _loc3_:Number = graphics.y;
         graphics.x = graphics.x + 0.025 * graphics.width;
         graphics.y = graphics.y + 0.025 * graphics.height;
         var _loc4_:* = 0.95;
         graphics.scaleY = _loc4_;
         graphics.scaleX = _loc4_;
         Starling.juggler.tween(graphics,0.25,{
            "transition":"easeOut",
            "delay":param1 * 0.05,
            "scaleX":1,
            "scaleY":1,
            "x":_loc2_,
            "y":_loc3_
         });
      }
      
      private function subscribe() : void
      {
         data.signal_updated.add(handler_updated);
      }
      
      private function unsubscribe() : void
      {
         data.signal_updated.remove(handler_updated);
      }
      
      private function handler_click() : void
      {
         if(data)
         {
            data.select();
         }
      }
      
      private function handler_updated() : void
      {
         button_buy.graphics.visible = !data.bought;
         tf_bought.visible = data.bought;
         tf_desc.text = data.desc;
         tf_name.text = data.name;
      }
   }
}
