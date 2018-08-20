package game.view.specialoffer.herochoice
{
   import engine.core.utils.property.ObjectProperty;
   import engine.core.utils.property.ObjectPropertyWriteable;
   import feathers.data.ListCollection;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.skills.SkillDescription;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.model.user.specialoffer.PlayerSpecialOfferHeroChoice;
   import game.view.popup.PopupBase;
   import org.osflash.signals.Signal;
   
   public class SpecialOfferHeroChoiceSelectorPopupMediator extends PopupMediator
   {
       
      
      private var _offer:PlayerSpecialOfferHeroChoice;
      
      private var _selectedHero:ObjectPropertyWriteable;
      
      public const signal_heroSelected:Signal = new Signal(HeroDescription);
      
      public const dataProvider:ListCollection = new ListCollection();
      
      public function SpecialOfferHeroChoiceSelectorPopupMediator(param1:Player, param2:PlayerSpecialOfferHeroChoice)
      {
         _selectedHero = new ObjectPropertyWriteable(SpecialOfferHeroChoiceHeroValueObject,null);
         super(param1);
         _offer = param2;
         _offer.heroes.onValue(handler_heroes);
         _offer.signal_removed.add(handler_removed);
      }
      
      override protected function dispose() : void
      {
         super.dispose();
         _offer.heroes.unsubscribe(handler_heroes);
         _offer.signal_removed.remove(handler_removed);
         signal_heroSelected.removeAll();
      }
      
      public function get selectedHero() : ObjectProperty
      {
         return _selectedHero;
      }
      
      public function get selectedHeroSkills() : Vector.<SkillDescription>
      {
         var _loc1_:Vector.<SkillDescription> = DataStorage.skill.getUpgradableSkillsByHero((_selectedHero.value as SpecialOfferHeroChoiceHeroValueObject).unit.id);
         _loc1_.sort(SkillDescription.sort_byTier);
         return _loc1_;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new SpecialOfferHeroChoiceSelectorPopup(this);
         return new SpecialOfferHeroChoiceSelectorPopup(this);
      }
      
      public function action_selectHero(param1:SpecialOfferHeroChoiceHeroValueObject) : void
      {
         _selectedHero.value = param1;
      }
      
      public function action_complete() : void
      {
         signal_heroSelected.dispatch((_selectedHero.value as SpecialOfferHeroChoiceHeroValueObject).unit as HeroDescription);
         close();
      }
      
      private function sort_units(param1:UnitDescription, param2:UnitDescription) : int
      {
         if(param1.obtainType && !param2.obtainType)
         {
            return -1;
         }
         if(!param1.obtainType && param2.obtainType)
         {
            return 1;
         }
         if(param1.id > param2.id)
         {
            return -1;
         }
         if(param1.id < param2.id)
         {
            return 1;
         }
         return 0;
      }
      
      private function handler_heroes(param1:Vector.<UnitDescription>) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         param1.sort(sort_units);
         var _loc2_:Vector.<SpecialOfferHeroChoiceHeroValueObject> = new Vector.<SpecialOfferHeroChoiceHeroValueObject>();
         var _loc7_:int = 0;
         var _loc6_:* = param1;
         for each(var _loc3_ in param1)
         {
            _loc4_ = new SpecialOfferHeroChoiceHeroValueObject(_loc3_,player.heroes.getById(_loc3_.id) != null);
            if(_loc3_ == _offer.selectedHero.value)
            {
               _loc5_ = _loc4_;
            }
            _loc2_.push(_loc4_);
         }
         dataProvider.data = _loc2_;
         if(_selectedHero.value == null)
         {
            if(_loc5_)
            {
               _selectedHero.value = _loc5_;
            }
            else if(param1.length > 0)
            {
               _selectedHero.value = _loc2_[0];
            }
         }
      }
      
      private function handler_removed() : void
      {
         close();
      }
   }
}
