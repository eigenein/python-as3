package game.view.popup.clan.editicon
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.clan.editicon.ClanEditIconCanvasValueObject;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipListItem;
   import game.view.gui.components.controller.IButtonView;
   import game.view.gui.components.controller.TouchButtonController;
   import idv.cjcat.signals.Signal;
   
   public class ClipListItemClanEditIconCanvas extends ClipListItem implements IButtonView
   {
       
      
      private var flag:ClanIconClip;
      
      private var data:ClanEditIconCanvasValueObject;
      
      private var buttonController:TouchButtonController;
      
      private const signal_click:Signal = new Signal(Object);
      
      public var flag_layout:ClipLayout;
      
      public var layout:ClipLayout;
      
      public var icon_check:ClipSprite;
      
      public var selection:ClipSprite;
      
      public function ClipListItemClanEditIconCanvas()
      {
         flag_layout = ClipLayout.verticalCenter(0);
         layout = ClipLayout.verticalCenter(0);
         super();
         buttonController = new TouchButtonController(_container,this);
      }
      
      override public function dispose() : void
      {
         buttonController.dispose();
         if(data)
         {
            data.signal_graphicsUpdated.remove(handler_graphicsUpdated);
         }
      }
      
      override public function get signal_select() : Signal
      {
         return signal_click;
      }
      
      public function setupState(param1:String, param2:Boolean) : void
      {
         selection.graphics.visible = param1 == "down" || param1 == "hover";
      }
      
      public function click() : void
      {
         signal_click.dispatch(data);
      }
      
      override public function setData(param1:*) : void
      {
         if(data)
         {
            data.signal_graphicsUpdated.remove(handler_graphicsUpdated);
         }
         data = param1 as ClanEditIconCanvasValueObject;
         selection.graphics.visible = false;
         if(data)
         {
            handler_graphicsUpdated();
            data.signal_graphicsUpdated.add(handler_graphicsUpdated);
         }
      }
      
      override public function setSelected(param1:Boolean) : void
      {
         this.icon_check.graphics.visible = param1;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         flag = AssetStorage.rsx.clan_icons.createFlagClip();
         flag.graphics.width = flag_layout.width;
         flag.graphics.height = flag_layout.height;
         var _loc2_:* = Math.min(flag.graphics.scaleX,flag.graphics.scaleY);
         flag.graphics.scaleY = _loc2_;
         flag.graphics.scaleX = _loc2_;
         flag_layout.addChild(flag.graphics);
      }
      
      private function handler_graphicsUpdated() : void
      {
         flag.setupCanvas(data.colorPatternTexture,data.color1,data.color2);
      }
   }
}
