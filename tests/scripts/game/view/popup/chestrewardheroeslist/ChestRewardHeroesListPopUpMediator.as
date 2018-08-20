package game.view.popup.chestrewardheroeslist
{
   import game.data.storage.chest.ChestRewardPresentationValueObject;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.skills.SkillDescription;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   
   public class ChestRewardHeroesListPopUpMediator extends PopupMediator
   {
       
      
      private var _rewardHeros:Array;
      
      public function ChestRewardHeroesListPopUpMediator(param1:Player, param2:Array)
      {
         super(param1);
         this._rewardHeros = param2;
         this._rewardHeros.sort(sortRewardHeroes);
      }
      
      public function get rewardHeros() : Array
      {
         return _rewardHeros;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ChestRewardHeroesListPopUp(this);
         return _popup;
      }
      
      public function sortRewardHeroes(param1:ChestRewardPresentationValueObject, param2:ChestRewardPresentationValueObject) : int
      {
         if(param1.is_unique && !param2.is_unique)
         {
            return -1;
         }
         if(!param1.is_unique && param2.is_unique)
         {
            return 1;
         }
         if(param1.is_new && !param2.is_new)
         {
            return -1;
         }
         if(!param1.is_new && param2.is_new)
         {
            return 1;
         }
         if((param1.item as UnitDescription).obtainType && !(param2.item as UnitDescription).obtainType)
         {
            return -1;
         }
         if(!(param1.item as UnitDescription).obtainType && (param2.item as UnitDescription).obtainType)
         {
            return 1;
         }
         if(param1.item.id > param2.item.id)
         {
            return -1;
         }
         if(param1.item.id < param2.item.id)
         {
            return 1;
         }
         return 0;
      }
      
      public function sortSkills(param1:SkillDescription, param2:SkillDescription) : int
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
