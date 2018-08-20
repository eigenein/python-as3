package game.screen
{
   import com.progrestar.framework.ares.starling.StarlingClipNode;
   import game.battle.controller.BattleMediatorObjects;
   import game.battle.controller.thread.BattleThread;
   import game.battle.controller.thread.ClanWarHeroBattleThread;
   import game.battle.controller.thread.ReplayBattleThread;
   import game.battle.controller.thread.TitanArenaBattleThread;
   import game.battle.controller.thread.TitanChallengeBattleThread;
   import game.battle.gui.BattleGuiView;
   import game.battle.gui.BattleGuiViewBase;
   import game.battle.gui.BattleReplayGuiView;
   import game.battle.view.BattleScene;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   
   public class BattleScreen extends GameScreen implements ITutorialNodePresenter, IBattleScreen
   {
       
      
      private var _gui:BattleGuiViewBase;
      
      private var _scene:BattleScene;
      
      private var _thread:BattleThread;
      
      public function BattleScreen()
      {
         super(1);
      }
      
      public function get gui() : BattleGuiViewBase
      {
         return _gui;
      }
      
      public function get scene() : BattleScene
      {
         return _scene;
      }
      
      public function get objects() : BattleMediatorObjects
      {
         return _thread.objects;
      }
      
      public function get thread() : BattleThread
      {
         return _thread;
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.BATTLE_SCREEN;
      }
      
      public function start(param1:BattleThread) : void
      {
         _thread = param1;
         if(param1 is ReplayBattleThread || param1 is TitanChallengeBattleThread || param1 is ClanWarHeroBattleThread && (param1 as ClanWarHeroBattleThread).isReplay || param1 is TitanArenaBattleThread && (param1 as TitanArenaBattleThread).isReplay)
         {
            _gui = new BattleReplayGuiView();
         }
         else
         {
            _gui = new BattleGuiView();
         }
         _scene = new BattleScene(param1.controller.soundConfig);
         _gui.subscribeSceneGraphics(_scene.graphics);
         graphics.addChild(_scene.graphics);
         graphics.addChild(_gui.graphics);
      }
      
      public function clear() : void
      {
         if(_thread)
         {
            _thread.dispose();
            _thread = null;
         }
         if(_gui)
         {
            _gui.dispose();
            if(_scene)
            {
               _gui.unsubscribeSceneGraphics(_scene.graphics);
            }
            _gui = null;
         }
         if(_scene)
         {
            _scene.dispose();
            _scene = null;
         }
         StarlingClipNode.clearFilterCache();
      }
   }
}
