package game.battle.view.hero
{
   import battle.BattleEngine;
   import game.assets.battle.BattleAsset;
   import game.battle.controller.BattleMediator;
   import game.battle.controller.BattleMediatorObjects;
   import game.battle.controller.thread.Battle;
   import game.battle.view.BattleGraphicsMethodProvider;
   import game.battle.view.BattleGraphicsProvider;
   import game.battle.view.BattleScene;
   import game.screen.BattleScreen;
   
   public class BattleContext
   {
       
      
      public var parent:Battle;
      
      public var engine:BattleEngine;
      
      public var mediator:BattleMediator;
      
      public var objects:BattleMediatorObjects;
      
      public var scene:BattleScene;
      
      public var screen:BattleScreen;
      
      public var fx:BattleGraphicsProvider;
      
      public var graphics:BattleGraphicsMethodProvider;
      
      public var asset:BattleAsset;
      
      public function BattleContext()
      {
         super();
      }
   }
}
