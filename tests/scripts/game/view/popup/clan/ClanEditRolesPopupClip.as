package game.view.popup.clan
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipInput;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.refillable.CostButton;
   
   public class ClanEditRolesPopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_close:ClipButton;
      
      public var tf_header:ClipLabel;
      
      public var bg:GuiClipScale9Image;
      
      public var tf_label_role_owner:ClipLabel;
      
      public var tf_input_role_owner:ClipInput;
      
      public var tf_label_role_officer:ClipLabel;
      
      public var tf_input_role_officer:ClipInput;
      
      public var tf_label_role_member:ClipLabel;
      
      public var tf_input_role_member:ClipInput;
      
      public var tf_label_role_warlord:ClipLabel;
      
      public var tf_input_role_warlord:ClipInput;
      
      public var tf_label_save_roles:ClipLabel;
      
      public var tf_label_is_updating:ClipLabel;
      
      public var button_save_roles:CostButton;
      
      public function ClanEditRolesPopupClip()
      {
         button_close = new ClipButton();
         tf_header = new ClipLabel();
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         button_save_roles = new CostButton();
         super();
      }
   }
}
