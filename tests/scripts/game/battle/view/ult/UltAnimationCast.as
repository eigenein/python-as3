package game.battle.view.ult
{
   import battle.data.BattleSkillDescription;
   import battle.skills.SkillCast;
   import game.battle.view.hero.HeroView;
   
   public class UltAnimationCast
   {
       
      
      protected var _hero:HeroView;
      
      protected var _skill:BattleSkillDescription;
      
      protected var timeLeft:Number;
      
      protected var delayBeforeAnimation:Number;
      
      protected var fadeOutDuration:Number;
      
      protected var maxUltScale:Number;
      
      protected var _stopTime:Boolean;
      
      protected var blackScreen:Boolean;
      
      public function UltAnimationCast(param1:SkillCast, param2:Number, param3:Number, param4:Boolean, param5:Boolean)
      {
         super();
         this.fadeOutDuration = param3;
         this.timeLeft = param2 + param3;
         this._stopTime = param4;
         this.blackScreen = param5;
         this._skill = param1.skill;
         param1.addOnStop(handler_skillCastStop);
      }
      
      public function get hero() : HeroView
      {
         return _hero;
      }
      
      public function get stopTime() : Boolean
      {
         return _stopTime && timeLeft > fadeOutDuration;
      }
      
      public function get showBlackScreen() : Boolean
      {
         return blackScreen;
      }
      
      public function get targetHeroScale() : Number
      {
         return timeLeft > fadeOutDuration?maxUltScale:1;
      }
      
      public function get finished() : Boolean
      {
         return timeLeft <= 0;
      }
      
      public function get skill() : BattleSkillDescription
      {
         return _skill;
      }
      
      public function setHero(param1:HeroView, param2:Number, param3:Number) : void
      {
         this._hero = param1;
         this.delayBeforeAnimation = param2;
         this.maxUltScale = param3;
      }
      
      public function advanceTime(param1:Number) : void
      {
         timeLeft = timeLeft - param1;
         if(hero != null)
         {
            if(delayBeforeAnimation >= 0)
            {
               delayBeforeAnimation = delayBeforeAnimation - param1;
               if(delayBeforeAnimation < 0)
               {
               }
            }
            if(stopTime && delayBeforeAnimation < 0)
            {
               hero.advanceTime(param1);
            }
            if(finished)
            {
               hero.transform.scale = targetHeroScale;
            }
            else
            {
               hero.transform.scale = hero.transform.scale * 0.5 + targetHeroScale * 0.5;
            }
         }
      }
      
      protected function handler_skillCastStop(param1:SkillCast) : void
      {
         delayBeforeAnimation = -1;
         timeLeft = 0;
      }
   }
}
