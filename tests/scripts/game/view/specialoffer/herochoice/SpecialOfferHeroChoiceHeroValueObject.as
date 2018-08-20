package game.view.specialoffer.herochoice
{
   import game.data.storage.hero.UnitDescription;
   
   public class SpecialOfferHeroChoiceHeroValueObject
   {
       
      
      private var _unit:UnitDescription;
      
      private var _isPlayerUnit:Boolean;
      
      public function SpecialOfferHeroChoiceHeroValueObject(param1:UnitDescription, param2:Boolean)
      {
         super();
         this._unit = param1;
         this._isPlayerUnit = param2;
      }
      
      public function get unit() : UnitDescription
      {
         return _unit;
      }
      
      public function get isPlayerUnit() : Boolean
      {
         return _isPlayerUnit;
      }
   }
}
