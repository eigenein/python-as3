package game.view.popup.tower
{
   import game.assets.storage.AssetStorage;
   import game.battle.gui.BattleGUIProgressbarBlock;
   import game.mediator.gui.popup.team.TeamGatherPopupHeroValueObject;
   import game.mediator.gui.popup.tower.TowerTeamGatherHeroValueObject;
   import game.view.popup.team.TeamGatherPopupHeroRenderer;
   
   public class TowerTeamGatherPopupHeroRenderer extends TeamGatherPopupHeroRenderer
   {
       
      
      public var state:BattleGUIProgressbarBlock;
      
      private var dead_label:TowerTeamGatherPopupHeroRendererDeadLabelClip;
      
      public function TowerTeamGatherPopupHeroRenderer()
      {
         state = AssetStorage.rsx.popup_theme.create_hero_state_bars_block();
         dead_label = AssetStorage.rsx.popup_theme.tower_hero_dead_label();
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         state.graphics.x = 0;
         state.graphics.y = 93;
         state.graphics.touchable = false;
         dead_label.graphics.touchable = false;
         addChild(state.graphics);
         addChild(dead_label.graphics);
         button.height = 124;
         explicitWidth = 96;
      }
      
      override protected function updateState(param1:TeamGatherPopupHeroValueObject) : void
      {
         var _loc3_:TowerTeamGatherHeroValueObject = param1 as TowerTeamGatherHeroValueObject;
         if(!_loc3_)
         {
            return;
         }
         updateHeroBattleState(_loc3_);
         var _loc2_:Boolean = _loc3_ && _loc3_.isAvailable;
         var _loc4_:Boolean = _loc2_ && _loc3_ && _loc3_.selected;
         var _loc5_:Boolean = !_loc3_ || _loc3_.isEmpty || !_loc3_.isOwned;
         button.isEnabled = _loc2_;
         checkIcon.visible = _loc4_;
         portrait.disabled = _loc4_ || !_loc2_;
         portrait.visible = !_loc5_;
         emptySlot.visible = _loc5_;
      }
      
      protected function updateHeroBattleState(param1:TowerTeamGatherHeroValueObject) : void
      {
         if(param1)
         {
            state.hp = param1.relativeHp;
            state.energy = param1.relativeEnergy;
            state.disabled = param1.selected || param1.isDead;
         }
         else
         {
            state.hp = 0;
            state.energy = 0;
            state.disabled = true;
         }
         dead_label.visible = param1 && param1.isDead;
      }
   }
}
