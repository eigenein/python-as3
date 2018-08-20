package game.view.popup.clan
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeledUnderlined;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.arena.PlayerPortraitClip;
   
   public class ClanInfoPopupMemberListItemRendererClip extends GuiClipNestedContainer
   {
       
      
      public var button_dismiss:ClipButton;
      
      public var button_edit:ClipButton;
      
      public var button_profile:ClipButtonLabeledUnderlined;
      
      public var portrait:PlayerPortraitClip;
      
      public var tf_level:ClipLabel;
      
      public var tf_nickname:ClipLabel;
      
      public var tf_online:ClipLabel;
      
      public var tf_role:ClipLabel;
      
      public var tf_points_dungeon:ClipLabel;
      
      public var tf_points_daily:ClipLabel;
      
      public var icon_dungeon:ClipSprite;
      
      public var icon_activity:ClipSprite;
      
      public var layout_rank:ClipLayout;
      
      public var layout_points:ClipLayout;
      
      public var layout_name:ClipLayout;
      
      public var cutePanel_BG_12_12_12_12_inst0:GuiClipScale9Image;
      
      public function ClanInfoPopupMemberListItemRendererClip()
      {
         button_dismiss = new ClipButton();
         button_edit = new ClipButton();
         button_profile = new ClipButtonLabeledUnderlined();
         portrait = new PlayerPortraitClip(false);
         tf_level = new ClipLabel();
         tf_nickname = new ClipLabel();
         tf_online = new ClipLabel();
         tf_role = new ClipLabel(true);
         tf_points_dungeon = new ClipLabel(true);
         tf_points_daily = new ClipLabel(true);
         icon_dungeon = new ClipSprite();
         icon_activity = new ClipSprite();
         layout_rank = ClipLayout.horizontalMiddleCentered(4,tf_role,button_edit,button_dismiss);
         layout_points = ClipLayout.horizontalMiddleRight(4,tf_points_dungeon,icon_dungeon,tf_points_daily,icon_activity);
         layout_name = ClipLayout.verticalMiddleLeft(0,tf_nickname,tf_level,button_profile);
         cutePanel_BG_12_12_12_12_inst0 = new GuiClipScale9Image();
         super();
      }
   }
}
