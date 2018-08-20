package game.view.popup.rating
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.assets.storage.AssetStorage;
   import game.command.rpc.rating.CommandRatingTopGetResultArenaEntry;
   import game.command.rpc.rating.CommandRatingTopGetResultClanDungeonEntry;
   import game.command.rpc.rating.CommandRatingTopGetResultClanEntry;
   import game.command.rpc.rating.CommandRatingTopGetResultEntry;
   import game.command.rpc.rating.CommandRatingTopGetResultGrandEntry;
   import game.command.rpc.rating.CommandRatingTopGetResultNYTreeDecorateActionsEntry;
   import game.command.rpc.rating.CommandRatingTopGetResultUserEntry;
   import game.mechanics.grand.popup.TooltipGrandEnemyTeams;
   import game.mediator.gui.popup.clan.ClanIconWithFrameClip;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.arena.PlayerPortraitClip;
   import game.view.popup.arena.TooltipMiniTeamView;
   
   public class RatingPopupListItemRendererClip extends GuiClipNestedContainer
   {
       
      
      public var tf_name:ClipLabel;
      
      public var tf_label_rating_value:ClipLabel;
      
      public var tf_level:ClipLabel;
      
      public var tf_no_level:ClipLabel;
      
      public var tf_place:ClipLabel;
      
      public var tf_rating_value:ClipLabel;
      
      public var tf_label_place:ClipLabel;
      
      public var medal_image:GuiClipImage;
      
      public var portrait:PlayerPortraitClip;
      
      public var clan_icon:ClanIconWithFrameClip;
      
      public var bg:GuiClipScale9Image;
      
      public var name_bg:GuiClipScale9Image;
      
      public function RatingPopupListItemRendererClip()
      {
         tf_name = new ClipLabel();
         tf_label_rating_value = new ClipLabel();
         tf_level = new ClipLabel();
         tf_no_level = new ClipLabel();
         tf_place = new ClipLabel();
         tf_rating_value = new ClipLabel();
         tf_label_place = new ClipLabel();
         medal_image = new GuiClipImage();
         portrait = new PlayerPortraitClip();
         clan_icon = new ClanIconWithFrameClip();
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         name_bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         super();
      }
      
      public function dispose() : void
      {
         if(clan_icon)
         {
            clan_icon.dispose();
         }
         graphics.dispose();
      }
      
      override public function setNode(param1:Node) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function commitData(param1:CommandRatingTopGetResultEntry) : void
      {
         var _loc4_:int = param1.place;
         var _loc2_:Boolean = medal_image.graphics && _loc4_ <= 3 && _loc4_ != 0;
         if(_loc2_)
         {
            medal_image.image.texture = AssetStorage.rsx.popup_theme.getTexture("place" + _loc4_);
         }
         else if(_loc4_ != 0)
         {
            tf_place.text = String(_loc4_);
         }
         else
         {
            tf_place.text = "?";
         }
         if(medal_image.graphics)
         {
            medal_image.graphics.visible = _loc2_;
         }
         tf_place.graphics.visible = !_loc2_;
         var _loc3_:Boolean = param1.hasLevel;
         tf_level.visible = _loc3_;
         tf_no_level.visible = !_loc3_;
         if(_loc3_)
         {
            tf_level.text = param1.levelString;
         }
         else
         {
            tf_no_level.text = param1.noLevelString;
         }
         tf_name.text = param1.name;
         tf_rating_value.text = param1.ratingValue;
         tf_label_rating_value.text = param1.ratingValueLabel;
         if(bg.graphics)
         {
            TooltipHelper.removeTooltip(bg.graphics);
         }
         if(param1 is CommandRatingTopGetResultUserEntry)
         {
            setupUser(param1 as CommandRatingTopGetResultUserEntry);
            if(param1 is CommandRatingTopGetResultArenaEntry)
            {
               setupArena(param1 as CommandRatingTopGetResultArenaEntry);
            }
         }
         else if(param1 is CommandRatingTopGetResultClanEntry)
         {
            setupClan(param1 as CommandRatingTopGetResultClanEntry);
         }
         else if(param1 is CommandRatingTopGetResultNYTreeDecorateActionsEntry)
         {
            setupClanNYTreeDecorateActions(param1 as CommandRatingTopGetResultNYTreeDecorateActionsEntry);
         }
         else if(param1 is CommandRatingTopGetResultClanDungeonEntry)
         {
            setupClanDungeon(param1 as CommandRatingTopGetResultClanDungeonEntry);
         }
      }
      
      protected function setupUser(param1:CommandRatingTopGetResultUserEntry) : void
      {
         tf_label_place.text = Translate.translate("UI_DIALOG_RATING_MY_PLACE");
         var _loc2_:CommandRatingTopGetResultUserEntry = param1 as CommandRatingTopGetResultUserEntry;
         portrait.setData(_loc2_.userInfo);
         clan_icon.setData(_loc2_.clanInfo);
         portrait.graphics.visible = true;
      }
      
      protected function setupArena(param1:CommandRatingTopGetResultArenaEntry) : void
      {
         var _loc2_:* = null;
         if(param1.hasTeams && bg.graphics)
         {
            if(param1 is CommandRatingTopGetResultGrandEntry)
            {
               _loc2_ = new TooltipVO(TooltipGrandEnemyTeams,param1,"TooltipVO.HINT_BEHAVIOR_MOVING");
            }
            else
            {
               _loc2_ = new TooltipVO(TooltipMiniTeamView,param1,"TooltipVO.HINT_BEHAVIOR_MOVING");
            }
            TooltipHelper.addTooltip(bg.graphics,_loc2_);
         }
      }
      
      protected function setupClan(param1:CommandRatingTopGetResultClanEntry) : void
      {
         tf_label_place.text = Translate.translate("UI_DIALOG_RATING_GUILD_PLACE");
         var _loc2_:CommandRatingTopGetResultClanEntry = param1 as CommandRatingTopGetResultClanEntry;
         clan_icon.setData(_loc2_.clan);
         portrait.graphics.visible = false;
      }
      
      protected function setupClanNYTreeDecorateActions(param1:CommandRatingTopGetResultNYTreeDecorateActionsEntry) : void
      {
         tf_label_place.text = Translate.translate("UI_DIALOG_RATING_GUILD_PLACE");
         clan_icon.setData(param1.clan);
         portrait.graphics.visible = false;
      }
      
      protected function setupClanDungeon(param1:CommandRatingTopGetResultClanDungeonEntry) : void
      {
         tf_label_place.text = Translate.translate("UI_DIALOG_RATING_GUILD_PLACE");
         clan_icon.setData(param1.clan);
         portrait.graphics.visible = false;
      }
   }
}
