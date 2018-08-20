package game.view.popup.clan
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.common.CutePanelClipButton;
   
   public class ClanSearchListItemRendererClip extends GuiClipNestedContainer
   {
       
      
      public var button_join:ClipButtonLabeled;
      
      public var tf_guild_level_req:ClipLabel;
      
      public var tf_guild_members:ClipLabel;
      
      public var tf_guild_name:ClipLabel;
      
      public var tf_guild_points:ClipLabel;
      
      public var icon_human:ClipSprite;
      
      public var icon_points:ClipSprite;
      
      public var lock_icon:ClipSprite;
      
      public var layout_icon:ClipLayout;
      
      public var clan_icon_frame:ClipSprite;
      
      public var button_friends:ClipButton;
      
      public var bg_button:CutePanelClipButton;
      
      public function ClanSearchListItemRendererClip()
      {
         button_join = new ClipButtonLabeled();
         tf_guild_level_req = new ClipLabel();
         tf_guild_members = new ClipLabel();
         tf_guild_name = new ClipLabel(true);
         tf_guild_points = new ClipLabel();
         icon_human = new ClipSprite();
         icon_points = new ClipSprite();
         lock_icon = new ClipSprite();
         layout_icon = ClipLayout.none();
         clan_icon_frame = new ClipSprite();
         button_friends = new ClipButton();
         bg_button = new CutePanelClipButton();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         var _loc2_:* = false;
         tf_guild_points.touchable = _loc2_;
         _loc2_ = _loc2_;
         tf_guild_name.touchable = _loc2_;
         _loc2_ = _loc2_;
         tf_guild_members.touchable = _loc2_;
         tf_guild_level_req.touchable = _loc2_;
         _loc2_ = false;
         icon_points.graphics.touchable = _loc2_;
         _loc2_ = _loc2_;
         icon_human.graphics.touchable = _loc2_;
         _loc2_ = _loc2_;
         layout_icon.graphics.touchable = _loc2_;
         _loc2_ = _loc2_;
         lock_icon.graphics.touchable = _loc2_;
         clan_icon_frame.graphics.touchable = _loc2_;
      }
   }
}
