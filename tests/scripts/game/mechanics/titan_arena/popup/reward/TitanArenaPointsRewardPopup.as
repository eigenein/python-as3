package game.mechanics.titan_arena.popup.reward
{
   import com.progrestar.common.lang.Translate;
   import engine.core.assets.AssetList;
   import engine.core.assets.RequestableAsset;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.command.timer.GameTimer;
   import game.data.storage.titanarenaleague.TitanArenaReward;
   import game.data.storage.titanarenaleague.TitanArenaTournamentReward;
   import game.mechanics.titan_arena.mediator.reward.TitanArenaPointsRewardPopupMediator;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   
   public class TitanArenaPointsRewardPopup extends AsyncClipBasedPopupWithPreloader
   {
       
      
      private var mediator:TitanArenaPointsRewardPopupMediator;
      
      private var clip:TitanArenaPointsRewardPopupClip;
      
      private var _progressAsset:RequestableAsset;
      
      public function TitanArenaPointsRewardPopup(param1:TitanArenaPointsRewardPopupMediator)
      {
         super(param1,AssetStorage.rsx.dialog_titan_arena);
         this.mediator = param1;
         var _loc2_:AssetList = new AssetList();
         _loc2_.addAssets(AssetStorage.rsx.dialog_titan_arena);
         _progressAsset = _loc2_;
         AssetStorage.instance.globalLoader.requestAsset(_loc2_);
      }
      
      override public function dispose() : void
      {
         GameTimer.instance.oneSecTimer.remove(handler_timer);
         super.dispose();
      }
      
      override protected function get progressAsset() : RequestableAsset
      {
         return _progressAsset;
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         super.onAssetLoaded(param1);
         clip = AssetStorage.rsx.dialog_titan_arena.create(TitanArenaPointsRewardPopupClip,"dialog_titan_arena_points_reward");
         addChild(clip.graphics);
         width = 790;
         height = 470;
         clip.title = Translate.translate("UI_DIALOG_TITAN_ARENA_POINTS_REWARD_TITLE");
         clip.button_close.signal_click.add(mediator.close);
         clip.tf_victory_reward.text = Translate.translate("UI_DIALOG_TITAN_ARENA_POINTS_REWARD_VICTORY_REWARD");
         clip.tf_place_reward.text = Translate.translate("UI_DIALOG_TITAN_ARENA_POINTS_REWARD_PLACE_REWARD");
         clip.tf_points_reward.text = Translate.translate("UI_DIALOG_TITAN_ARENA_POINTS_REWARD_POINTS_REWARD");
         clip.victory_reward.action_button.label = Translate.translate("UI_DIALOG_TITAN_ARENA_POINTS_REWARD_BUTTON_VICTORY_REWARD");
         clip.place_reward.action_button.label = Translate.translate("UI_DIALOG_TITAN_ARENA_POINTS_REWARD_BUTTON_RATING_REWARD");
         clip.victory_reward.action_button.signal_click.add(mediator.action_rules_points);
         clip.place_reward.action_button.signal_click.add(mediator.action_rules_cups);
         clip.btn_farm.label = Translate.translate("UI_DIALOG_TITAN_ARENA_POINTS_REWARD_FARM");
         clip.btn_farm.signal_click.add(mediator.action_farmDailyReward);
         GameTimer.instance.oneSecTimer.add(handler_timer);
         updateStatus();
         updateState();
      }
      
      private function updateStatus() : void
      {
         clip.tf_label_status.text = mediator.string_status;
      }
      
      private function updateState() : void
      {
         var _loc6_:* = 0;
         var _loc3_:* = null;
         var _loc7_:* = 0;
         var _loc4_:* = null;
         var _loc2_:Boolean = false;
         var _loc8_:* = 0;
         clip.tf_week_points.text = Translate.translateArgs("UI_DIALOG_TITAN_ARENA_POINTS_REWARD_WEEK_POINTS",mediator.weeklyScore);
         var _loc9_:Vector.<TitanArenaReward> = mediator.victoryRewardList;
         _loc6_ = uint(0);
         while(_loc6_ < _loc9_.length)
         {
            if(_loc6_ == _loc9_.length - 1 || mediator.weeklyScore >= _loc9_[_loc6_].tournamentPoints && mediator.weeklyScore <= _loc9_[_loc6_ + 1].tournamentPoints)
            {
               if(_loc6_ < _loc9_.length - 1)
               {
                  _loc3_ = Translate.translateArgs("UI_DIALOG_TITAN_ARENA_RULES_POINTS_RANGE_1",_loc9_[_loc6_].tournamentPoints,_loc9_[_loc6_ + 1].tournamentPoints - 1);
               }
               else
               {
                  _loc3_ = Translate.translateArgs("UI_DIALOG_TITAN_ARENA_RULES_POINTS_RANGE_2",_loc9_[_loc6_].tournamentPoints);
               }
               _loc3_ = _loc3_ + (" " + Translate.translate("UI_DIALOG_TITAN_ARENA_POINTS_REWARD_POINTS_BY_WEEK"));
               clip.victory_reward.setData(_loc3_,_loc9_[_loc6_].reward);
               break;
            }
            _loc6_++;
         }
         var _loc5_:Vector.<TitanArenaTournamentReward> = mediator.tournamentRewardList;
         _loc7_ = uint(0);
         while(_loc7_ < _loc5_.length)
         {
            if(_loc7_ == _loc5_.length - 1 || mediator.place >= _loc5_[_loc7_].placeFrom && mediator.place <= _loc5_[_loc7_].placeTo)
            {
               if(_loc5_[_loc7_].placeFrom == _loc5_[_loc7_].placeTo)
               {
                  _loc4_ = Translate.translateArgs("UI_COMMON_PLACE",_loc5_[_loc7_].placeFrom);
               }
               else if(_loc7_ < _loc5_.length - 1)
               {
                  _loc4_ = Translate.translateArgs("UI_DIALOG_TITAN_ARENA_RULES_PLACE_RANGE_2",_loc5_[_loc7_].placeFrom,_loc5_[_loc7_].placeTo);
               }
               else
               {
                  _loc4_ = Translate.translateArgs("UI_DIALOG_TITAN_ARENA_RULES_PLACE_RANGE_3",_loc5_[_loc7_].placeFrom);
               }
               clip.place_reward.setData(_loc4_,_loc5_[_loc7_].winnerReward);
               break;
            }
            _loc7_++;
         }
         var _loc1_:Vector.<TitanArenaReward> = mediator.dailyRewardList;
         if(mediator.firstNotFarmedReward)
         {
            clip.progressbar.value = mediator.dailyScore;
            clip.progressbar.maxValue = mediator.firstNotFarmedReward.points;
            clip.reward.setData(mediator.totalNotFarmedReward.outputDisplayFirst);
            clip.tf_not_enought_to_farm_points.visible = false;
            clip.btn_farm.graphics.visible = true;
            clip.progressbar.container.visible = true;
            clip.reward.container.visible = true;
         }
         else
         {
            clip.tf_not_enought_to_farm_points.visible = true;
            clip.btn_farm.graphics.visible = false;
            _loc2_ = false;
            _loc8_ = uint(0);
            while(_loc8_ < _loc1_.length)
            {
               if(mediator.dailyScore < _loc1_[_loc8_].tournamentPoints)
               {
                  _loc2_ = true;
               }
               if(_loc2_ || _loc8_ == _loc1_.length - 1)
               {
                  if(_loc8_ > 0)
                  {
                     clip.progressbar.minValue = _loc1_[_loc8_ - 1].tournamentPoints;
                  }
                  else
                  {
                     clip.progressbar.minValue = 0;
                  }
                  clip.progressbar.maxValue = _loc1_[_loc8_].tournamentPoints;
                  clip.progressbar.value = mediator.dailyScore;
                  clip.reward.setData(_loc1_[_loc8_].reward.outputDisplayFirst);
                  break;
               }
               _loc8_++;
            }
            clip.reward.container.visible = _loc2_;
            if(_loc2_)
            {
               clip.tf_not_enought_to_farm_points.text = Translate.translateArgs("UI_DIALOG_TITAN_ARENA_POINTS_REWARD_NOT_ENOUGHT_TO_FARM_POINTS",clip.progressbar.maxValue - clip.progressbar.value);
            }
            else
            {
               clip.tf_not_enought_to_farm_points.text = Translate.translate("UI_DIALOG_TITAN_ARENA_POINTS_REWARD_EMPTY");
            }
         }
         clip.victory_reward.container.visible = true;
         clip.place_reward.container.visible = true;
      }
      
      private function handler_timer() : void
      {
         updateStatus();
      }
   }
}
