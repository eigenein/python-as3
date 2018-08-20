package game.mediator.gui.popup.hero
{
   import game.data.storage.enum.lib.HeroColor;
   import game.data.storage.gear.GearItemDescription;
   import game.data.storage.hero.HeroColorData;
   
   public class HeroGearListValueObject
   {
       
      
      private var data:HeroColorData;
      
      public function HeroGearListValueObject(param1:HeroColorData)
      {
         super();
         this.data = param1;
      }
      
      public function get itemList() : Vector.<GearItemDescription>
      {
         return data.itemList;
      }
      
      public function get color() : HeroColor
      {
         return data.color;
      }
   }
}
