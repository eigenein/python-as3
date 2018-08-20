package game.view.popup.statistics
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.battle.controller.statistic.BattleDamageStatistics;
   import game.battle.controller.statistic.BattleDamageStatisticsValueObject;
   import game.view.popup.ClipBasedPopup;
   
   public class BattleStatisticsPopup extends ClipBasedPopup
   {
       
      
      private var stats:BattleDamageStatistics;
      
      private var team1:Vector.<BattleDamageStatisticsValueObject>;
      
      private var team2:Vector.<BattleDamageStatisticsValueObject>;
      
      public function BattleStatisticsPopup(param1:Vector.<BattleDamageStatisticsValueObject>, param2:Vector.<BattleDamageStatisticsValueObject>)
      {
         super(null);
         this.team1 = param1;
         this.team2 = param2;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:BattleStatisticsPopupClip = AssetStorage.rsx.popup_theme.create_popup_battle_statistics();
         addChild(_loc1_.graphics);
         setupTeam(_loc1_.player_1,team1);
         setupTeam(_loc1_.player_2,team2);
         _loc1_.tf_header.text = Translate.translate("UI_DIALOG_STATISTICS_HEADER");
         _loc1_.button_close.signal_click.add(close);
      }
      
      private function setupTeam(param1:BattleStatisticsPopupTeamClip, param2:Vector.<BattleDamageStatisticsValueObject>) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = param1.panels.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(param2.length > _loc4_)
            {
               param1.panels[_loc4_].data = param2[_loc4_];
            }
            else
            {
               param1.panels[_loc4_].data = null;
            }
            _loc4_++;
         }
      }
   }
}
