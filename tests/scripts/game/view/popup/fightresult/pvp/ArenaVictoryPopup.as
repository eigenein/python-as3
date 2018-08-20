package game.view.popup.fightresult.pvp
{
   import com.progrestar.common.lang.Translate;
   import feathers.controls.List;
   import feathers.core.PopUpManager;
   import feathers.data.ListCollection;
   import feathers.layout.HorizontalLayout;
   import game.assets.storage.AssetStorage;
   import game.command.rpc.arena.ArenaBattleResultValueObject;
   import game.data.storage.DataStorage;
   import game.data.storage.arena.ArenaRewardDescription;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.fightresult.pve.RewardPopupHeroList;
   import game.view.popup.statistics.BattleStatisticsPopup;
   
   public class ArenaVictoryPopup extends ClipBasedPopup
   {
       
      
      private var result:ArenaBattleResultValueObject;
      
      private var clip:ArenaVictoryPopupClip;
      
      public function ArenaVictoryPopup(param1:ArenaBattleResultValueObject)
      {
         super(null);
         this.result = param1;
      }
      
      public function get placeRewardChanged() : Boolean
      {
         var _loc4_:Player = GameModel.instance.player;
         var _loc3_:int = Math.max(_loc4_.arena.getPlace(),result.oldPlace);
         var _loc2_:ArenaRewardDescription = DataStorage.arena.getRewardByPlace(_loc3_);
         var _loc1_:ArenaRewardDescription = DataStorage.arena.getRewardByPlace(result.newPlace);
         return _loc2_ != _loc1_;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_pvp_victory();
         addChild(clip.graphics);
         var _loc1_:Boolean = placeRewardChanged;
         clip.bounds_layout_container.validate();
         width = clip.bounds_layout_container.width;
         height = clip.bounds_layout_container.height;
         clip.tf_label_header.text = Translate.translate("UI_DIALOG_ARENA_VICTORY");
         clip.tf_caption.text = Translate.translate("UI_DIALOG_ARENA_VICTORY_PLACE");
         clip.tf_label_place.text = Translate.translate("UI_DIALOG_ARENA_RATING_BATTLES_LEFT");
         clip.tf_label_battles.text = Translate.translate("UI_DIALOG_ARENA_RATING_BATTLES_TILL_UNLOCK");
         if(!result)
         {
            clip.tf_place_before.text = "111";
            clip.tf_place_after.text = "110";
         }
         else
         {
            if(result.oldPlace)
            {
               clip.tf_place_before.text = String(result.oldPlace);
            }
            else
            {
               clip.tf_place_before.visible = false;
               clip.double_arrow_inst0.graphics.visible = false;
            }
            if(result.newPlace)
            {
               clip.tf_place_after.text = String(result.newPlace);
            }
            else
            {
               clip.tf_place_after.visible = false;
               clip.double_arrow_inst0.graphics.visible = false;
            }
            if(result.oldPlace == 0 && result.newPlace == 0)
            {
               _loc1_ = false;
               clip.tf_caption.visible = false;
               clip.tf_label_place.visible = true;
               clip.tf_label_battles.visible = true;
               clip.tf_place_after.visible = true;
               clip.tf_place_after.text = String(GameModel.instance.player.arena.rankingIsLockedBattlesLeft);
            }
            else
            {
               clip.tf_label_place.visible = false;
               clip.tf_label_battles.visible = false;
            }
         }
         if(_loc1_)
         {
            setupPlaceReward();
         }
         else
         {
            clip.middle_container.graphics.removeFromParent(true);
         }
         setupBattleReward();
         clip.button_stats_inst0.label = Translate.translate("UI_DIALOG_ARENA_VICTORY_STATS");
         clip.okButton.label = Translate.translate("UI_DIALOG_ARENA_VICTORY_OK");
         clip.button_stats_inst0.graphics.visible = result.result.battleStatistics;
         clip.button_stats_inst0.signal_click.add(handler_showStats);
         clip.okButton.signal_click.add(close);
         var _loc2_:RewardPopupHeroList = new RewardPopupHeroList(ArenaVictoryPopupHeroItemRenderer);
         _loc2_.width = clip.hero_list_layout_container.container.width;
         _loc2_.height = clip.hero_list_layout_container.container.height;
         clip.hero_list_layout_container.container.addChild(_loc2_);
         _loc2_.dataProvider = new ListCollection(result.result.attackers);
         whenDisplayed(playSound);
      }
      
      protected function setupPlaceReward() : void
      {
         clip.tf_label_reward.text = Translate.translate("UI_DIALOG_ARENA_VICTORY_PLACE_REWARD");
         var _loc1_:List = new List();
         var _loc2_:HorizontalLayout = new HorizontalLayout();
         _loc2_.gap = 10;
         _loc2_.useVirtualLayout = false;
         _loc1_.layout = _loc2_;
         _loc1_.itemRendererType = ArenaRewardListItemRenderer;
         _loc1_.scrollBarDisplayMode = "fixed";
         _loc1_.horizontalScrollPolicy = "off";
         _loc1_.verticalScrollPolicy = "off";
         _loc1_.dataProvider = new ListCollection(DataStorage.arena.getRewardByPlace(result.newPlace).arenaDailyReward.outputDisplay);
         clip.reward_layout.removeChildren();
         clip.reward_layout.addChild(clip.tf_label_reward);
         clip.reward_layout.addChild(_loc1_);
      }
      
      protected function setupBattleReward() : void
      {
         clip.tf_label_battle_reward.text = Translate.translate("UI_DIALOG_ARENA_VICTORY_REWARD");
         var _loc1_:List = new List();
         var _loc2_:HorizontalLayout = new HorizontalLayout();
         _loc2_.gap = 10;
         _loc2_.useVirtualLayout = false;
         _loc1_.layout = _loc2_;
         _loc1_.itemRendererType = ArenaRewardListItemRenderer;
         _loc1_.scrollBarDisplayMode = "fixed";
         _loc1_.horizontalScrollPolicy = "off";
         _loc1_.verticalScrollPolicy = "off";
         _loc1_.dataProvider = new ListCollection(DataStorage.rule.arenaRule.arenaVictoryReward.outputDisplay);
         clip.battle_reward_layout.removeChildren();
         clip.battle_reward_layout.addChild(clip.tf_label_battle_reward);
         clip.battle_reward_layout.addChild(_loc1_);
      }
      
      private function handler_showStats() : void
      {
         PopUpManager.addPopUp(new BattleStatisticsPopup(result.attackerTeamStats,result.defenderTeamStats));
      }
      
      private function playSound() : void
      {
         AssetStorage.sound.battleWin.play();
      }
   }
}
