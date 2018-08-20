package game.screen.navigator
{
   import flash.utils.Dictionary;
   import game.data.storage.DataStorage;
   import game.data.storage.refillable.RefillableDescription;
   import game.mechanics.boss.mediator.BossBattlesRefillPopupMediator;
   import game.mechanics.boss.mediator.CooldownRefillPopupMediator;
   import game.mechanics.grand.mediator.GrandBattlesRefillPopupMediator;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.alchemy.AlchemyPopupMediator;
   import game.mediator.gui.popup.arena.ArenaCooldownRefillPopupMediator;
   import game.mediator.gui.popup.arena.GrandArenaCooldownRefillPopupMediator;
   import game.mediator.gui.popup.refillable.ArenaBattlesRefillPopupMediator;
   import game.mediator.gui.popup.refillable.EliteMissionTriesRefillPopupMediator;
   import game.mediator.gui.popup.refillable.SkillPointsRefillPopupMediator;
   import game.mediator.gui.popup.refillable.StaminaRefillPopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.mission.PlayerEliteMissionEntry;
   
   public class RefillableNavigator extends NavigatorBase
   {
       
      
      protected var methodList:Dictionary;
      
      public function RefillableNavigator(param1:GameNavigator, param2:Player)
      {
         methodList = new Dictionary();
         super(param1,param2);
         methodList[DataStorage.refillable.getByIdent("alchemy")] = alchemy;
         methodList[DataStorage.refillable.getByIdent("arena_battle")] = arena_battles;
         methodList[DataStorage.refillable.getByIdent("arena_cooldown")] = arena_cooldown;
         methodList[DataStorage.refillable.getByIdent("grand_arena_battle")] = grand_battles;
         methodList[DataStorage.refillable.getByIdent("grand_arena_cooldown")] = grand_cooldown;
         methodList[DataStorage.refillable.getByIdent("stamina")] = stamina;
         methodList[DataStorage.refillable.getByIdent("skill_point")] = skillpoints;
         methodList[DataStorage.refillable.getByIdent("boss_battle")] = boss_battle;
         methodList[DataStorage.refillable.getByIdent("boss_cooldown")] = boss_cooldown;
      }
      
      public function navigate(param1:RefillableDescription, param2:PopupStashEventParams) : IRefillableNavigatorResult
      {
         if(methodList[param1])
         {
            return methodList[param1](param2);
         }
         return null;
      }
      
      protected function alchemy(param1:PopupStashEventParams) : IRefillableNavigatorResult
      {
         var _loc2_:AlchemyPopupMediator = new AlchemyPopupMediator(GameModel.instance.player);
         _loc2_.open(param1);
         return _loc2_;
      }
      
      protected function stamina(param1:PopupStashEventParams) : IRefillableNavigatorResult
      {
         var _loc2_:StaminaRefillPopupMediator = new StaminaRefillPopupMediator(GameModel.instance.player);
         _loc2_.open(param1);
         return _loc2_;
      }
      
      protected function arena_battles(param1:PopupStashEventParams) : IRefillableNavigatorResult
      {
         var _loc2_:ArenaBattlesRefillPopupMediator = new ArenaBattlesRefillPopupMediator(GameModel.instance.player,player.arena.description);
         _loc2_.open(param1);
         return _loc2_;
      }
      
      protected function arena_cooldown(param1:PopupStashEventParams) : IRefillableNavigatorResult
      {
         var _loc2_:ArenaCooldownRefillPopupMediator = new ArenaCooldownRefillPopupMediator(player,player.arena.description);
         _loc2_.open(param1);
         return _loc2_;
      }
      
      protected function grand_battles(param1:PopupStashEventParams) : IRefillableNavigatorResult
      {
         var _loc2_:GrandBattlesRefillPopupMediator = new GrandBattlesRefillPopupMediator(GameModel.instance.player,player.grand.description);
         _loc2_.open(param1);
         return _loc2_;
      }
      
      protected function grand_cooldown(param1:PopupStashEventParams) : IRefillableNavigatorResult
      {
         var _loc2_:GrandArenaCooldownRefillPopupMediator = new GrandArenaCooldownRefillPopupMediator(player,player.grand.description);
         _loc2_.open(param1);
         return _loc2_;
      }
      
      protected function skillpoints(param1:PopupStashEventParams) : IRefillableNavigatorResult
      {
         var _loc2_:SkillPointsRefillPopupMediator = new SkillPointsRefillPopupMediator(GameModel.instance.player);
         _loc2_.open(param1);
         return _loc2_;
      }
      
      protected function boss_battle(param1:PopupStashEventParams) : IRefillableNavigatorResult
      {
         var _loc2_:BossBattlesRefillPopupMediator = new BossBattlesRefillPopupMediator(GameModel.instance.player);
         _loc2_.open(param1);
         return _loc2_;
      }
      
      protected function boss_cooldown(param1:PopupStashEventParams) : IRefillableNavigatorResult
      {
         var _loc2_:CooldownRefillPopupMediator = new CooldownRefillPopupMediator(GameModel.instance.player);
         _loc2_.open(param1);
         return _loc2_;
      }
      
      public function mission_tries(param1:PlayerEliteMissionEntry, param2:PopupStashEventParams) : IRefillableNavigatorResult
      {
         var _loc3_:EliteMissionTriesRefillPopupMediator = new EliteMissionTriesRefillPopupMediator(GameModel.instance.player,param1);
         _loc3_.open(param2);
         return _loc3_;
      }
   }
}
