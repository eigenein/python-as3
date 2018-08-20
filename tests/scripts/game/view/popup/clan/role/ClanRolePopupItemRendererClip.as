package game.view.popup.clan.role
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mediator.gui.popup.clan.ClanEditRolePopupValueObject;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class ClanRolePopupItemRendererClip extends GuiClipNestedContainer
   {
       
      
      public var tf_message:ClipLabel;
      
      public var check:Vector.<ClipSprite>;
      
      public var redX:Vector.<ClipSprite>;
      
      public var layout_main:ClipLayout;
      
      public function ClanRolePopupItemRendererClip()
      {
         tf_message = new ClipLabel();
         check = new Vector.<ClipSprite>();
         redX = new Vector.<ClipSprite>();
         layout_main = ClipLayout.verticalMiddleCenter(0,tf_message);
         super();
      }
      
      public function setData(param1:ClanEditRolePopupValueObject) : void
      {
         var _loc3_:int = 0;
         tf_message.text = param1.name;
         var _loc2_:int = param1.values.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            redX[_loc3_].graphics.visible = !param1.values[_loc3_];
            check[_loc3_].graphics.visible = param1.values[_loc3_];
            _loc3_++;
         }
      }
   }
}
