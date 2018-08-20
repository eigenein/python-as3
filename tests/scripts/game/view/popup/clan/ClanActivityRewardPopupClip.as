package game.view.popup.clan
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class ClanActivityRewardPopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_campaign:ClipButtonLabeled;
      
      public var button_item_exchange:ClipButtonLabeled;
      
      public var button_forge:ClipButtonLabeled;
      
      public var button_close:ClipButton;
      
      public var tf__label_points:ClipLabel;
      
      public var tf_footer:ClipLabel;
      
      public var tf_guild_points:ClipLabel;
      
      public var tf_header:ClipLabel;
      
      public var tf_points_per_quest:ClipLabel;
      
      public var tf_label_points_per_quest:ClipLabel;
      
      public var tf_label_campaign:ClipLabel;
      
      public var tf_label_get_points:ClipLabel;
      
      public var tf_label_guild_points:ClipLabel;
      
      public var tf_label_item_exchange:ClipLabel;
      
      public var tf_label_personal_points:ClipLabel;
      
      public var tf_label_reward:ClipLabel;
      
      public var tf_label_forge:ClipLabel;
      
      public var tf_personal_points:ClipLabel;
      
      public var tf_reset:ClipLabel;
      
      public var icon_forge_activity:ClipSprite;
      
      public var clan_reward_renderer:Vector.<ClanActivityRewardPopupRendererClip>;
      
      public var icon_pts1:ClipSprite;
      
      public var icon_pts2:ClipSprite;
      
      public var icon_forge_check:ClipSprite;
      
      public var cutePanel_BG_12_12_12_12_inst0:GuiClipScale9Image;
      
      public var layout_forge_points:ClipLayout;
      
      public var layout_guild_points:ClipLayout;
      
      public var layout_personal_points:ClipLayout;
      
      public var bg:GuiClipScale9Image;
      
      public var button_gifts:ClipButtonLabeled;
      
      public var icon_new:ClipSprite;
      
      public function ClanActivityRewardPopupClip()
      {
         button_campaign = new ClipButtonLabeled();
         button_item_exchange = new ClipButtonLabeled();
         button_forge = new ClipButtonLabeled();
         button_close = new ClipButton();
         tf__label_points = new ClipLabel();
         tf_footer = new ClipLabel();
         tf_guild_points = new ClipLabel(true);
         tf_header = new ClipLabel();
         tf_points_per_quest = new ClipLabel(true);
         tf_label_points_per_quest = new ClipLabel(true);
         tf_label_campaign = new ClipLabel();
         tf_label_get_points = new ClipLabel();
         tf_label_guild_points = new ClipLabel(true);
         tf_label_item_exchange = new ClipLabel();
         tf_label_personal_points = new ClipLabel(true);
         tf_label_reward = new ClipLabel();
         tf_label_forge = new ClipLabel();
         tf_personal_points = new ClipLabel(true);
         tf_reset = new ClipLabel();
         icon_forge_activity = new ClipSprite();
         icon_pts1 = new ClipSprite();
         icon_pts2 = new ClipSprite();
         icon_forge_check = new ClipSprite();
         cutePanel_BG_12_12_12_12_inst0 = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         layout_forge_points = ClipLayout.horizontalMiddleCentered(3,icon_forge_activity,tf_points_per_quest);
         layout_guild_points = ClipLayout.horizontalMiddleCentered(4,tf_label_guild_points,icon_pts1,tf_guild_points);
         layout_personal_points = ClipLayout.horizontalMiddleCentered(4,tf_label_personal_points,icon_pts2,tf_personal_points);
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         button_gifts = new ClipButtonLabeled();
         icon_new = new ClipSprite();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
      }
   }
}
