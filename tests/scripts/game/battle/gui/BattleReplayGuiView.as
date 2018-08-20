package game.battle.gui
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.rsx.BattleGUIAsset;
   import game.battle.controller.BattleSettingsModel;
   import game.battle.controller.hero.BattleHeroControllerWithPanel;
   import game.battle.gui.hero.BattleGuiHeroPanelsStorage;
   import game.battle.gui.hero.BattleHeroPanelClip;
   
   public class BattleReplayGuiView extends BattleGuiViewBase
   {
      
      public static const X_OFFSET:Number = -10;
      
      private static const speedValues:Array = [0.5,1,2];
       
      
      private var panels:BattleGuiHeroPanelsStorage;
      
      private var teams:BattleGuiReplayTeamsClip;
      
      private var controls:BattleGuiReplayControlsClip;
      
      public function BattleReplayGuiView()
      {
         panels = new BattleGuiHeroPanelsStorage();
         teams = new BattleGuiReplayTeamsClip();
         controls = new BattleGuiReplayControlsClip();
         super();
      }
      
      override public function attachHeroPanel(param1:BattleHeroControllerWithPanel) : void
      {
         var _loc2_:BattleHeroPanelClip = panels.getPanelByHero(param1);
         if(param1.hero.team.direction > 0)
         {
            teams.layout_attackers.addHeroPanel(_loc2_.backGraphics,_loc2_.frontGraphics,_loc2_.battleOrder);
         }
         else
         {
            teams.layout_defenders.addHeroPanel(_loc2_.backGraphics,_loc2_.frontGraphics,_loc2_.battleOrder);
         }
      }
      
      override public function setAutoToggleable(param1:Boolean) : void
      {
         controls.button_auto.graphics.alpha = !!param1?1:0.5;
         controls.button_auto.isEnabled = param1;
      }
      
      override function handler_battleIsInteractive(param1:Boolean) : void
      {
         panels.enabled = param1;
      }
      
      override function subscribeSettings(param1:BattleSettingsModel) : void
      {
         super.subscribeSettings(param1);
         param1.auto.onValue(controls.button_auto.setIsSelectedSilently);
         param1.speedToggleIndex.onValue(handler_speedIndex);
      }
      
      override function unsubscribeSettings(param1:BattleSettingsModel) : void
      {
         super.unsubscribeSettings(param1);
         param1.auto.unsubscribe(controls.button_auto.setIsSelectedSilently);
         param1.speedToggleIndex.unsubscribe(handler_speedIndex);
      }
      
      override protected function resize(param1:Number, param2:Number) : void
      {
         super.resize(param1,param2);
         if(bottomGradient)
         {
            bottomGradient.width = param1;
            bottomGradient.y = param2 - bottomGradient.height;
         }
      }
      
      override protected function handler_battleGuiAssetLoaded(param1:BattleGUIAsset) : void
      {
         super.handler_battleGuiAssetLoaded(param1);
         param1.init_block_replay_teams(teams);
         addAnchoredObject(teams.graphics,NaN,NaN,10,NaN,-10);
         param1.init_block_replay_controls(controls);
         addAnchoredObject(controls.graphics,NaN,20,10,NaN,NaN);
         controls.button_auto.initialize(Translate.translate("UI_POPUP_BATTLE_AUTO"),handler_toggleAutoBattle,false);
         controls.button_speed.button.initialize(Translate.translate("UI_BATTLE_SPEED"),handler_speedButton);
         controls.button_speed.index = 1;
      }
      
      protected function handler_speedButton() : void
      {
         if(mediator)
         {
            mediator.action_toggleSpeed();
         }
      }
      
      protected function handler_speedIndex(param1:int) : void
      {
         if(controls.button_speed)
         {
            controls.button_speed.index = param1;
         }
      }
   }
}
