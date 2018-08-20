package game.view.gui.clanscreen
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import engine.core.utils.MathUtil;
   import game.assets.storage.AssetStorage;
   import game.data.storage.DataStorage;
   import game.model.user.Player;
   import game.model.user.clan.ClanPrivateInfoValueObject;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.clan.editicon.ClanIconClip;
   
   public class ClanScreenClanInfoBlock extends GuiClipNestedContainer
   {
       
      
      private var clan:ClanPrivateInfoValueObject;
      
      private var icon:ClanIconClip;
      
      private var progress_bar_maxWidth:int;
      
      public var layout_banner:ClipLayout;
      
      public var tf_points:ClipLabel;
      
      public var activity_icon:ClipSprite;
      
      public var tf_guild_name:ClipLabel;
      
      public var progress_bar:GuiClipScale3Image;
      
      public var button_activity:ClipButtonLabeled;
      
      public var button_members:ClipButtonLabeled;
      
      public var button_settings:ClipButtonLabeled;
      
      public var icon_new:ClipSprite;
      
      public function ClanScreenClanInfoBlock()
      {
         layout_banner = ClipLayout.none();
         tf_points = new ClipLabel();
         activity_icon = new ClipSprite();
         tf_guild_name = new ClipLabel(true);
         progress_bar = new GuiClipScale3Image();
         button_activity = new ClipButtonLabeled();
         button_members = new ClipButtonLabeled();
         button_settings = new ClipButtonLabeled();
         icon_new = new ClipSprite();
         super();
      }
      
      public function dispose() : void
      {
         if(this.clan != null)
         {
            unsubscribe(this.clan);
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         progress_bar_maxWidth = progress_bar.image.width;
         icon = AssetStorage.rsx.clan_icons.createFlagClip();
         var _loc2_:* = 0.7;
         icon.graphics.scaleY = _loc2_;
         icon.graphics.scaleX = _loc2_;
         layout_banner.addChild(icon.graphics);
         icon_new.graphics.touchable = false;
      }
      
      public function setData(param1:ClanPrivateInfoValueObject, param2:Player) : void
      {
         if(this.clan != null)
         {
            unsubscribe(this.clan);
            param2.clan.property_redMark_clanGiftCount.signal_update.remove(handler_redMarkUpdate_clanGiftCount);
         }
         this.clan = param1;
         if(this.clan == null)
         {
            return;
         }
         handler_iconUpdated();
         handler_titleUpdated();
         param1.signal_iconUpdated.add(handler_iconUpdated);
         param1.signal_titleUpdated.add(handler_titleUpdated);
         param1.activityPoints.onValue(handler_pointsUpdated);
         param2.clan.property_redMark_clanGiftCount.signal_update.add(handler_redMarkUpdate_clanGiftCount);
         handler_redMarkUpdate_clanGiftCount(param2.clan.property_redMark_clanGiftCount.value);
      }
      
      private function unsubscribe(param1:ClanPrivateInfoValueObject) : void
      {
         param1.signal_iconUpdated.remove(handler_iconUpdated);
         param1.signal_titleUpdated.remove(handler_titleUpdated);
         param1.activityPoints.unsubscribe(handler_pointsUpdated);
      }
      
      private function handler_titleUpdated() : void
      {
         tf_guild_name.text = clan.title;
      }
      
      private function handler_pointsUpdated(param1:int) : void
      {
         var _loc2_:int = DataStorage.clanActivityReward.getMaxPoints();
         var _loc3_:Number = MathUtil.clamp(param1 / _loc2_,0,1);
         var _loc4_:int = 5;
         progress_bar.image.width = _loc4_ + _loc3_ * (progress_bar_maxWidth - _loc4_);
         tf_points.text = param1 + "/" + _loc2_;
      }
      
      private function handler_iconUpdated() : void
      {
         AssetStorage.rsx.clan_icons.setupFlag(icon,clan.icon);
      }
      
      private function handler_redMarkUpdate_clanGiftCount(param1:Boolean) : void
      {
         icon_new.graphics.visible = param1;
      }
   }
}
