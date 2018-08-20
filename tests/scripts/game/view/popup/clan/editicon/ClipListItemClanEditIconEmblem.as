package game.view.popup.clan.editicon
{
   import engine.core.clipgui.ClipSprite;
   import game.mediator.gui.popup.clan.editicon.ClanEditIconEmblemValueObject;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipListItem;
   import game.view.gui.components.controller.IButtonView;
   import game.view.gui.components.controller.TouchButtonController;
   import idv.cjcat.signals.Signal;
   import starling.display.Image;
   
   public class ClipListItemClanEditIconEmblem extends ClipListItem implements IButtonView
   {
       
      
      private var data:ClanEditIconEmblemValueObject;
      
      private var image:Image;
      
      private var buttonController:TouchButtonController;
      
      private const signal_click:Signal = new Signal(Object);
      
      public var layout:ClipLayout;
      
      public var icon_check:ClipSprite;
      
      public function ClipListItemClanEditIconEmblem()
      {
         layout = ClipLayout.horizontalMiddleCentered(0);
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
         data = param1 as ClanEditIconEmblemValueObject;
         if(!data)
         {
            return;
         }
         if(!image)
         {
            image = new Image(data.emblemTexture);
            layout.addChild(image);
         }
         handler_graphicsUpdated();
         data.signal_graphicsUpdated.add(handler_graphicsUpdated);
      }
      
      override public function setSelected(param1:Boolean) : void
      {
         this.icon_check.graphics.visible = param1;
      }
      
      private function handler_graphicsUpdated() : void
      {
         if(data)
         {
            image.texture = data.emblemTexture;
            image.width = image.texture.width;
            image.height = image.texture.height;
            image.color = data.color;
            layout.invalidate();
         }
      }
   }
}
