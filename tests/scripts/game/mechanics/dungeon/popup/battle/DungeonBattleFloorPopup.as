package game.mechanics.dungeon.popup.battle
{
   import game.assets.storage.AssetStorage;
   import game.mechanics.dungeon.mediator.DungeonBattleFloorPopupMediator;
   import game.mechanics.dungeon.model.PlayerDungeonBattleEnemy;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.popup.ClipBasedPopup;
   
   public class DungeonBattleFloorPopup extends ClipBasedPopup implements ITutorialNodePresenter
   {
       
      
      private var clip:DungeonBattleFloorPopupClipBase;
      
      private var mediator:DungeonBattleFloorPopupMediator;
      
      public function DungeonBattleFloorPopup(param1:DungeonBattleFloorPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      public function get tutorialNode() : TutorialNode
      {
         if(mediator.isTitanFloor)
         {
            return TutorialNavigator.CLAN_DUNGEON_SELECT_ENEMY_TITAN;
         }
         return TutorialNavigator.CLAN_DUNGEON_SELECT_ENEMY_HERO;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         if(mediator.enemy_2)
         {
            clip = AssetStorage.rsx.dungeon_floors.create(DungeonBattleDoubleFloorPopupClip,"dialog_dungeon_battle_floor");
         }
         else
         {
            clip = AssetStorage.rsx.dungeon_floors.create(DungeonBattleFloorPopupClipBase,"dialog_dungeon_battle_floor_single");
         }
         addChild(clip.graphics);
         clip.button_close.signal_click.add(mediator.close);
         clip.title = mediator.floorLabel;
         if(mediator.enemy_1)
         {
            clip.enemy_1.setData(mediator.enemy_1);
         }
         if(mediator.enemy_2)
         {
            (clip as DungeonBattleDoubleFloorPopupClip).enemy_2.setData(mediator.enemy_2);
            (clip as DungeonBattleDoubleFloorPopupClip).enemy_2.button_attack.signal_click.add(handler_chooseHard);
         }
         updateEnemiesDisabled();
         mediator.difficultyUpdated.add(updateEnemiesDisabled);
         clip.enemy_1.button_attack.signal_click.add(handler_chooseNormal);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
      }
      
      private function updateEnemiesDisabled() : void
      {
      }
      
      private function setupEnemyClipDisabled(param1:DungeonBattleEnemyPanelClip, param2:PlayerDungeonBattleEnemy) : void
      {
         var _loc3_:Boolean = false;
         param1.setDisabled(_loc3_);
      }
      
      private function chooseDifficulty(param1:int) : void
      {
         mediator.action_gatherTeam(param1);
      }
      
      private function handler_chooseNormal() : void
      {
         chooseDifficulty(1);
      }
      
      private function handler_chooseHard() : void
      {
         chooseDifficulty(2);
      }
   }
}
