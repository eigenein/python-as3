package game.view.popup.tower
{
   import game.assets.storage.AssetStorage;
   import game.data.storage.tower.TowerBattleDifficulty;
   import game.mediator.gui.popup.tower.TowerBattleFloorPopupMediator;
   import game.model.user.tower.PlayerTowerBattleEnemy;
   import game.view.popup.ClipBasedPopup;
   
   public class TowerBattleFloorPopup extends ClipBasedPopup
   {
       
      
      private const clip:TowerBattleFloorPopupClip = AssetStorage.rsx.popup_theme.create_dialog_tower_battle_floor();
      
      private var mediator:TowerBattleFloorPopupMediator;
      
      public function TowerBattleFloorPopup(param1:TowerBattleFloorPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         mediator.difficultyUpdated.remove(updateEnemiesDisabled);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         addChild(clip.graphics);
         clip.button_close.signal_click.add(mediator.close);
         clip.title = mediator.floorLabel;
         clip.enemy_1.setData(mediator.enemyNormal);
         updateEnemiesDisabled();
         mediator.difficultyUpdated.add(updateEnemiesDisabled);
         clip.enemy_1.button_attack.signal_click.add(handler_chooseNormal);
         clip.enemy_1.button_skip.signal_click.add(mediator.action_buySkip);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         clip.enemy_1.button_skip.container.visible = mediator.mayBuySkip;
      }
      
      private function updateEnemiesDisabled() : void
      {
         setupEnemyClipDisabled(clip.enemy_1,mediator.enemyNormal);
      }
      
      private function setupEnemyClipDisabled(param1:TowerBattleEnemyPanelClip, param2:PlayerTowerBattleEnemy) : void
      {
         var _loc3_:Boolean = false;
         param1.setDisabled(_loc3_);
      }
      
      private function chooseDifficulty(param1:TowerBattleDifficulty) : void
      {
         if(mediator.difficultySelected)
         {
            mediator.action_gatherTeam(param1);
         }
         else
         {
            mediator.action_chooseDifficulty(param1);
         }
      }
      
      private function setNextFloor() : void
      {
         var _loc1_:Boolean = false;
         clip.tf_skip_label.graphics.visible = _loc1_;
         clip.button_skip.graphics.visible = _loc1_;
         clip.button_skip.graphics.visible = true;
      }
      
      private function handler_chooseNormal() : void
      {
         chooseDifficulty(TowerBattleDifficulty.NORMAL);
      }
      
      private function handler_chooseHard() : void
      {
         chooseDifficulty(TowerBattleDifficulty.HARD);
      }
   }
}
