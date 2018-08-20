package battle.skills
{
   import battle.Hero;
   import flash.Boot;
   
   public class HeroCollectionAvailableIterator
   {
       
      
      public var length:int;
      
      public var index:int;
      
      public var heroes:Vector.<Hero>;
      
      public function HeroCollectionAvailableIterator(param1:HeroCollection = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         index = 0;
         length = int(param1.heroes.length);
         heroes = param1.heroes;
      }
      
      public function next() : Hero
      {
         var _loc1_:int = index;
         index = index + 1;
         return heroes[_loc1_];
      }
      
      public function hasNext() : Boolean
      {
         return index < length && heroes[index].get_isAvailable();
      }
   }
}
