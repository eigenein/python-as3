package game.view.popup.clan.editicon
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipImage;
   import game.mediator.gui.popup.clan.editicon.ClanEditIconColorValueObject;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipListItem;
   import game.view.gui.components.controller.IButtonView;
   import game.view.gui.components.controller.TouchButtonController;
   import idv.cjcat.signals.Signal;
   
   public class ClipListItemClanEditIconColor extends ClipListItem implements IButtonView
   {
       
      
      private var data:ClanEditIconColorValueObject;
      
      private var signal_click:Signal;
      
      private var buttonController:TouchButtonController;
      
      public var layout:ClipLayout;
      
      public var icon_check:ClipSprite;
      
      public var color:GuiClipImage;
      
      public var selection:ClipSprite;
      
      public var frame:ClipSprite;
      
      public function ClipListItemClanEditIconColor()
      {
         signal_click = new Signal(Object);
         layout = ClipLayout.none();
         super();
         buttonController = new TouchButtonController(_container,this);
      }
      
      override public function dispose() : void
      {
         buttonController.dispose();
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
         data = param1 as ClanEditIconColorValueObject;
         if(!data)
         {
            return;
         }
         selection.graphics.visible = false;
         color.image.color = data.color;
      }
      
      override public function setSelected(param1:Boolean) : void
      {
         icon_check.graphics.visible = param1;
      }
   }
}
