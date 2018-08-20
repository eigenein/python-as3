package game.mechanics.titan_arena.mediator
{
   import com.progrestar.common.lang.Translate;
   import game.battle.controller.MultiBattleResult;
   import game.mechanics.titan_arena.model.command.CommandTitanArenaEndBattle;
   import game.mechanics.titan_arena.popup.TitanArenaBattleEndPopup;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   
   public class TitanArenaBattleEndPopupMediator extends TitanArenaRoundEndPopupMeditatorBase
   {
       
      
      private var _hpPercentState:Vector.<Number>;
      
      private var _defBattleResult:MultiBattleResult;
      
      private var _roundResult_def:TitanArenaRoundResultValueObject;
      
      public function TitanArenaBattleEndPopupMediator(param1:Player, param2:CommandTitanArenaEndBattle, param3:MultiBattleResult = null)
      {
         super(param1,param2);
         _defBattleResult = param3;
         _roundResult_def = param2.result_defense;
      }
      
      public function get defBattleResult() : MultiBattleResult
      {
         return _defBattleResult;
      }
      
      public function get roundResult_def() : TitanArenaRoundResultValueObject
      {
         return _roundResult_def;
      }
      
      public function get reward_defensePoints_string() : String
      {
         return cmd.pointsEarned_defense_total.toString();
      }
      
      public function get reward_defensePoints_improveString() : String
      {
         var _loc1_:* = cmd.pointsEarned_defense == cmd.pointsEarned_defense_total;
         if(cmd.pointsEarned_defense && !_loc1_)
         {
            return Translate.translateArgs("UI_TITAN_ARENA_BATTLE_END_POPUP_RESULT_IMPROVED",cmd.pointsEarned_defense);
         }
         return "";
      }
      
      public function get reward_attackPoints_string() : String
      {
         return cmd.pointsEarned_attack_total.toString();
      }
      
      public function get reward_attackPoints_improveString() : String
      {
         var _loc1_:* = cmd.pointsEarned_attack == cmd.pointsEarned_attack_total;
         if(cmd.pointsEarned_attack && !_loc1_)
         {
            return Translate.translateArgs("UI_TITAN_ARENA_BATTLE_END_POPUP_RESULT_IMPROVED",cmd.pointsEarned_attack);
         }
         return "";
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TitanArenaBattleEndPopup(this);
         return _popup;
      }
   }
}
