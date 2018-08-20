package game.mechanics.grand.popup
{
   import com.progrestar.common.lang.Translate;
   import feathers.controls.List;
   import feathers.data.ListCollection;
   import feathers.layout.HorizontalLayout;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.DialogBattleDefeatAsset;
   import game.command.rpc.arena.ArenaBattleResultValueObject;
   import game.data.storage.arena.ArenaRewardDescription;
   import game.mechanics.grand.mediator.GrandBattleResultValueObject;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.fightresult.pvp.ArenaRewardListItemRenderer;
   import game.view.popup.statistics.BattleStatisticsPopup;
   import idv.cjcat.signals.Signal;
   
   public class GrandBattleResultFinalPopup extends ClipBasedPopup
   {
       
      
      private var data:GrandBattleResultValueObject;
      
      private var clip:GrandBattleResultFinalPopupClip;
      
      private var header:GrandBattleResultHeaderClip;
      
      public const signal_continue:Signal = new Signal();
      
      public function GrandBattleResultFinalPopup(param1:GrandBattleResultValueObject)
      {
         super(null);
         this.data = param1;
      }
      
      override protected function initialize() : void
      {
         var _loc2_:* = 0;
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_grand_victory_final();
         addChild(clip.graphics);
         clip.button_continue.initialize(Translate.translate("ОК"),handler_continue);
         clip.button_stats.initialize(Translate.translate("UI_DIALOG_ARENA_VICTORY_STATS"),handler_stats);
         clip.tf_caption.text = Translate.translate("UI_DIALOG_ARENA_VICTORY_PLACE");
         clip.tf_label_reward.text = Translate.translate("UI_DIALOG_ARENA_VICTORY_PLACE_REWARD");
         if(data.win)
         {
            setupHeader(AssetStorage.rsx.popup_theme.create_victory_header_background());
         }
         else
         {
            AssetStorage.instance.globalLoader.requestAssetWithCallback(AssetStorage.rsx.dialog_battle_defeat,handler_battleDefeatAsset);
         }
         setupPlace();
         setupPlaceReward();
         var _loc3_:int = data.battleCount;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            setBattleClip(clip.battles[_loc2_],data.getBattleAt(_loc2_),_loc2_);
            _loc2_++;
         }
         var _loc1_:int = clip.battles.length;
         _loc2_ = _loc3_;
         while(_loc2_ < _loc1_)
         {
            clip.battles[_loc2_].graphics.removeFromParent(true);
            _loc2_++;
         }
         whenDisplayed(playSound);
         clip.container_all.height = NaN;
         clip.container_battles.height = NaN;
         clip.container_all.validate();
         centerPopupBy(clip.graphics);
      }
      
      protected function setBattleClip(param1:GrandBattleResultBattleClip, param2:ArenaBattleResultValueObject, param3:int) : void
      {
         param1.block_attacker.team.reversed = true;
         param1.block_attacker.team.setUnitTeam(param2.result.attackers);
         param1.block_attacker.tf_victory.visible = param2.win;
         param1.block_attacker.tf_defeat.visible = !param2.win;
         param1.block_defender.team.setUnitTeam(param2.result.defenders);
         param1.block_defender.tf_victory.visible = !param2.win;
         param1.block_defender.tf_defeat.visible = param2.win;
         if(param1.block_number)
         {
            param1.block_number.text = String(param3 + 1);
         }
         if(clip.container_battles)
         {
            clip.container_battles.addChild(param1.graphics);
         }
      }
      
      protected function setupPlace() : void
      {
         if(data.win)
         {
            clip.tf_place_before.text = String(data.oldPlace);
            clip.tf_place_after.text = String(data.newPlace);
         }
         else
         {
            clip.container_place.removeFromParent(true);
         }
      }
      
      protected function setupPlaceReward() : void
      {
         if(!data.win || !data.placeRewardChanged)
         {
            clip.container_reward.removeFromParent(true);
            return;
         }
         var _loc1_:ArenaRewardDescription = data.placeReward;
         var _loc2_:List = new List();
         var _loc3_:HorizontalLayout = new HorizontalLayout();
         _loc3_.gap = 10;
         _loc3_.padding = 5;
         _loc3_.useVirtualLayout = false;
         _loc3_.verticalAlign = "top";
         _loc3_.horizontalAlign = "center";
         _loc2_.layout = _loc3_;
         _loc2_.itemRendererType = ArenaRewardListItemRenderer;
         _loc2_.scrollBarDisplayMode = "fixed";
         _loc2_.horizontalScrollPolicy = "off";
         _loc2_.verticalScrollPolicy = "off";
         _loc2_.width = clip.reward_list_layout_container.container.width;
         _loc2_.height = clip.reward_list_layout_container.container.height;
         clip.reward_list_layout_container.container.addChild(_loc2_);
         _loc2_.dataProvider = new ListCollection(_loc1_.arenaDailyReward.outputDisplay);
      }
      
      protected function setupHeader(param1:GrandBattleResultHeaderClip) : void
      {
         param1.tf_label_header.text = !!data.win?Translate.translate("UI_DIALOG_GRAND_VICTORY"):Translate.translate("UI_DIALOG_GRAND_DEFEAT");
         clip.container_header.addChild(param1.graphics);
      }
      
      private function playSound() : void
      {
         AssetStorage.sound.battleWin.play();
      }
      
      protected function handler_battleDefeatAsset(param1:DialogBattleDefeatAsset) : void
      {
         setupHeader(param1.create_defeat_header_background());
      }
      
      protected function handler_continue() : void
      {
         close();
         signal_continue.dispatch();
         signal_continue.clear();
      }
      
      protected function handler_stats() : void
      {
         var _loc1_:ArenaBattleResultValueObject = data.currentBattle;
         var _loc2_:BattleStatisticsPopup = new BattleStatisticsPopup(_loc1_.attackerTeamStats,_loc1_.defenderTeamStats);
         _loc2_.open();
      }
   }
}
