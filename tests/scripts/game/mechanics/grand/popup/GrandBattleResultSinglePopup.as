package game.mechanics.grand.popup
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.DialogBattleDefeatAsset;
   import game.command.rpc.arena.ArenaBattleResultValueObject;
   import game.mechanics.grand.mediator.GrandBattleResultValueObject;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.statistics.BattleStatisticsPopup;
   import idv.cjcat.signals.Signal;
   
   public class GrandBattleResultSinglePopup extends ClipBasedPopup
   {
       
      
      private var data:GrandBattleResultValueObject;
      
      private var clip:GrandBattleResultSinglePopupClip;
      
      private var header:GrandBattleResultHeaderClip;
      
      public const signal_continue:Signal = new Signal();
      
      public function GrandBattleResultSinglePopup(param1:GrandBattleResultValueObject)
      {
         super(null);
         this.data = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_grand_victory_single();
         addChild(clip.graphics);
         width = clip.bounds_layout_container.graphics.width;
         height = clip.bounds_layout_container.graphics.height;
         clip.button_continue.initialize(Translate.translate("UI_DIALOG_GRAND_NEXT_BATTLE"),handler_continue);
         clip.button_stats.initialize(Translate.translate("UI_DIALOG_ARENA_VICTORY_STATS"),handler_stats);
         clip.tf_label_score.text = Translate.translate("UI_DIALOG_GRAND_SCORE");
         clip.tf_score.text = data.getScoreString();
         clip.panel_attacker.data = data.attacker;
         clip.panel_defender.data = data.defender;
         var _loc1_:Boolean = data.win;
         if(_loc1_)
         {
            setupHeader(AssetStorage.rsx.popup_theme.create_victory_header_background());
         }
         else
         {
            AssetStorage.instance.globalLoader.requestAssetWithCallback(AssetStorage.rsx.dialog_battle_defeat,handler_battleDefeatAsset);
         }
      }
      
      protected function setupHeader(param1:GrandBattleResultHeaderClip) : void
      {
         param1.tf_label_header.text = !!data.win?Translate.translate("UI_DIALOG_GRAND_VICTORY"):Translate.translate("UI_DIALOG_GRAND_DEFEAT");
         addChildAt(param1.graphics,0);
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
