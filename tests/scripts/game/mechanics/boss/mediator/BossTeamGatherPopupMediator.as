package game.mechanics.boss.mediator
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.mechanics.boss.popup.BossTeamGatherPopup;
   import game.mechanics.boss.storage.BossTypeDescription;
   import game.mediator.gui.popup.hero.HeroEntryValueObject;
   import game.mediator.gui.popup.hero.UnitUtils;
   import game.mediator.gui.popup.team.TeamGatherHeroBlockReason;
   import game.mediator.gui.popup.team.TeamGatherPopupHeroValueObject;
   import game.mediator.gui.popup.team.TeamGatherPopupMediator;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.stat.Stash;
   import game.view.gui.tutorial.Tutorial;
   import game.view.popup.PopupBase;
   
   public class BossTeamGatherPopupMediator extends TeamGatherPopupMediator
   {
       
      
      private var boss:BossTypeDescription;
      
      public function BossTeamGatherPopupMediator(param1:Player, param2:BossTypeDescription)
      {
         this.boss = param2;
         var _loc3_:Vector.<UnitDescription> = param1.heroes.teamData.getByBossType(param2);
         if(_loc3_ == null)
         {
            _loc3_ = new Vector.<UnitDescription>();
         }
         super(param1,_loc3_);
      }
      
      public function get recommendedHeroesText() : String
      {
         return boss.recommendedHeroesText;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new BossTeamGatherPopup(this);
         _popup.stashParams.windowName = "team_gather:" + MechanicStorage.BOSS.type;
         return _popup;
      }
      
      override public function action_complete() : void
      {
         if(teamListDataProvider.length)
         {
            player.heroes.teamData.saveTeamByBossDescription(descriptionList,boss);
            _signal_teamGatherComplete.dispatch(this);
            Tutorial.events.triggerEvent_teamSelectionCompleted();
            Stash.click("go",_popup.stashParams);
         }
      }
      
      override protected function getAllHeroes() : Vector.<UnitDescription>
      {
         return UnitUtils.heroVectorToUnitVector(boss.recommendedHeroes);
      }
      
      override protected function createHeroValueObject(param1:UnitDescription) : TeamGatherPopupHeroValueObject
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:HeroDescription = param1 as HeroDescription;
         var _loc5_:PlayerHeroEntry = player.heroes.getById(param1.id);
         if(_loc5_)
         {
            _loc2_ = new TeamGatherPopupHeroValueObject(this,new HeroEntryValueObject(_loc3_,_loc5_));
            _loc4_ = isHeroUnavailable(_loc2_);
            if(_loc4_)
            {
               _loc2_.setUnavailable(_loc4_);
            }
            return _loc2_;
         }
         if(param1.isPlayable)
         {
            _loc2_ = new TeamGatherPopupHeroValueObject(this,new HeroEntryValueObject(_loc3_,null));
            _loc4_ = new TeamGatherHeroBlockReason(Translate.translate("UI_DIALOG_BOSS_NO_HERO"));
            if(_loc4_)
            {
               _loc2_.setUnavailable(_loc4_);
            }
            return _loc2_;
         }
         return null;
      }
   }
}
