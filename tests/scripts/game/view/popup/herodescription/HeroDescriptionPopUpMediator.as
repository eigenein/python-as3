package game.view.popup.herodescription
{
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.skills.SkillDescription;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.inventory.ItemInfoPopupMediator;
   import game.model.user.Player;
   import game.model.user.hero.HeroUtils;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   
   public class HeroDescriptionPopUpMediator extends PopupMediator
   {
       
      
      public var recieveInfoMode:Boolean;
      
      public var hero:HeroDescription;
      
      public function HeroDescriptionPopUpMediator(param1:Player, param2:HeroDescription, param3:Boolean = false)
      {
         super(param1);
         this.hero = param2;
         this.recieveInfoMode = param3;
      }
      
      public function get heroName() : String
      {
         return hero.name;
      }
      
      public function get heroDescText() : String
      {
         return hero.descText;
      }
      
      public function get skillsDescription() : String
      {
         return HeroUtils.getFullRolesDescription(hero);
      }
      
      public function get skillList() : Vector.<SkillDescription>
      {
         var _loc1_:Vector.<SkillDescription> = DataStorage.skill.getUpgradableSkillsByHero(hero.id);
         _loc1_.sort(sortSkills);
         return _loc1_;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new HeroDescriptionPopUp(this);
         return _popup;
      }
      
      public function showRecieveInfo() : void
      {
         var _loc1_:ItemInfoPopupMediator = new ItemInfoPopupMediator(player,hero);
         _loc1_.open(Stash.click("item_info",_popup.stashParams));
      }
      
      private function sortSkills(param1:SkillDescription, param2:SkillDescription) : int
      {
         if(param1.tier > param2.tier)
         {
            return 1;
         }
         if(param1.tier < param2.tier)
         {
            return -1;
         }
         return 0;
      }
   }
}
