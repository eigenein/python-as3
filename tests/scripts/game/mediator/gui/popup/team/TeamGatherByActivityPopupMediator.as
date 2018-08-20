package game.mediator.gui.popup.team
{
   import avmplus.getQualifiedClassName;
   import com.progrestar.common.lang.Translate;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.mechanic.MechanicDescription;
   import game.mediator.gui.popup.PopupList;
   import game.model.user.Player;
   import game.stat.Stash;
   import game.view.gui.tutorial.Tutorial;
   import game.view.popup.PopupBase;
   import game.view.popup.team.TeamGatherRSXPopup;
   
   public class TeamGatherByActivityPopupMediator extends TeamGatherPopupMediator
   {
       
      
      protected var activity:MechanicDescription;
      
      protected var blockReason:TeamGatherHeroBlockReason;
      
      public function TeamGatherByActivityPopupMediator(param1:Player, param2:MechanicDescription)
      {
         this.player = param1;
         this.activity = param2;
         var _loc3_:Vector.<UnitDescription> = getDefaultTeam();
         if(_loc3_)
         {
            _loc3_ = _loc3_.filter(filterAvailableHeroes);
         }
         blockReason = new TeamGatherHeroBlockReason(Translate.translateArgs("UI_DIALOG_TEAM_GATHER_LEVEL_NEEDED",param2.minHeroLevel));
         super(param1,_loc3_);
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TeamGatherRSXPopup(this);
         _popup.stashParams.windowName = "team_gather:" + activity.type;
         return _popup;
      }
      
      override public function action_pick(param1:TeamGatherPopupHeroValueObject, param2:Number = 0.2) : void
      {
         if(param1.isEmpty)
         {
            return;
         }
         if(param1.level < activity.minHeroLevel)
         {
            PopupList.instance.message(blockReason.text);
            return;
         }
         super.action_pick(param1,param2);
      }
      
      override public function action_complete() : void
      {
         if(teamListDataProvider.length)
         {
            player.heroes.teamData.saveTeam(descriptionList,activity);
            _signal_teamGatherComplete.dispatch(this);
            Tutorial.events.triggerEvent_teamSelectionCompleted();
            Stash.click("go",_popup.stashParams);
         }
      }
      
      protected function getDefaultTeam() : Vector.<UnitDescription>
      {
         return player.heroes.teamData.getByActivity(activity);
      }
      
      protected function filterAvailableHeroes(param1:UnitDescription, param2:int, param3:Vector.<UnitDescription>) : Boolean
      {
         if(player.heroes.getById(param1.id))
         {
            return true;
         }
         trace(getQualifiedClassName(this),"У player нет в наличии героя с id " + param1.id + " но он выбран в качестве текущего члена команды " + activity.teamType);
         return false;
      }
      
      override public function isHeroUnavailable(param1:TeamGatherPopupHeroValueObject) : TeamGatherHeroBlockReason
      {
         if(!param1.isEmpty && param1.level >= activity.minHeroLevel)
         {
            return null;
         }
         return blockReason;
      }
   }
}
