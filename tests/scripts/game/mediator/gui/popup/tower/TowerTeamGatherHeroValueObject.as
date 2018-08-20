package game.mediator.gui.popup.tower
{
   import game.data.storage.DataStorage;
   import game.data.storage.hero.UnitDescription;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.team.TeamGatherPopupHeroValueObject;
   import game.mediator.gui.popup.team.TeamGatherPopupMediator;
   import game.model.user.hero.UnitEntry;
   import game.model.user.tower.TowerHeroState;
   
   public class TowerTeamGatherHeroValueObject extends TeamGatherPopupHeroValueObject
   {
       
      
      private var state:TowerHeroState;
      
      public function TowerTeamGatherHeroValueObject(param1:TeamGatherPopupMediator, param2:UnitDescription, param3:UnitEntry, param4:TowerHeroState)
      {
         super(param1,UnitEntryValueObject.create(param2,param3));
         this.state = param4;
      }
      
      public function get relativeHp() : Number
      {
         if(isEmpty)
         {
            return 0;
         }
         if(!state)
         {
            return 1;
         }
         return state.hp / state.maxHp;
      }
      
      public function get relativeEnergy() : Number
      {
         if(isEmpty)
         {
            return 0;
         }
         if(!state)
         {
            return 0;
         }
         return state.energy / DataStorage.battleConfig.pve.defaultMaxEnergy;
      }
      
      public function get isDead() : Boolean
      {
         return !!state?state.isDead:false;
      }
      
      override public function get isAvailable() : Boolean
      {
         return super.isAvailable && !isDead;
      }
   }
}
