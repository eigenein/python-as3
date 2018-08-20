package game.data.storage.skills
{
   public class SkillBehaviorDescription
   {
       
      
      public var behavior:String;
      
      public var params:Array;
      
      public var range:int;
      
      public var cooldown:Number;
      
      public var cooldownInitial:Number;
      
      public var animationDelay:Number;
      
      public var prime:SkillActionDescription;
      
      public var secondary:SkillActionDescription;
      
      public var projectile:Object;
      
      public var effect:String;
      
      public var hitrate:int;
      
      public var duration:Number;
      
      public var hits:int;
      
      public var area:Number;
      
      public var delay:Number;
      
      public function SkillBehaviorDescription(param1:*)
      {
         super();
         behavior = param1.behavior;
         range = param1.range;
         cooldown = param1.cooldown;
         cooldownInitial = param1.cooldownInitial;
         animationDelay = param1.animationDelay;
         prime = SkillActionDescription.create(param1.prime);
         secondary = SkillActionDescription.create(param1.secondary);
         projectile = param1.projectile;
         effect = param1.effect;
         hitrate = param1.hitrate;
         duration = param1.duration;
         hits = param1.hits;
         area = param1.area;
         delay = param1.delay;
         params = [];
         var _loc4_:int = 0;
         var _loc3_:* = param1.params;
         for each(var _loc2_ in param1.params)
         {
            params.push(new SkillParameterDescription(_loc2_));
         }
      }
   }
}
