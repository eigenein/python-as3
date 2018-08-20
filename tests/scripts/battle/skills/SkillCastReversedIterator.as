package battle.skills
{
   import battle.Hero;
   import flash.Boot;
   
   public class SkillCastReversedIterator
   {
       
      
      public var targets:Vector.<Hero>;
      
      public var i:int;
      
      public function SkillCastReversedIterator(param1:SkillCast = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         i = param1.targetsCount;
         targets = param1.targets;
      }
      
      public function next() : Hero
      {
         return targets[i];
      }
      
      public function hasNext() : Boolean
      {
         var _loc1_:int = i;
         i = i - 1;
         return _loc1_ > 0;
      }
   }
}
