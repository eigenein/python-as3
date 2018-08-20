package battle.log
{
   import battle.BattleEngine;
   import battle.DamageValue;
   import battle.Hero;
   import battle.Team;
   import battle.objects.BattleBody;
   import battle.skills.Effect;
   import battle.skills.SkillCast;
   import flash.Boot;
   
   public class BattleLogBase
   {
       
      
      public var engine:BattleEngine;
      
      public var bytes:BattleLogWriter;
      
      public function BattleLogBase()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         bytes = new BattleLogWriter();
         BattleLogEncoder.init();
      }
      
      public function toggleAuto(param1:Team) : void
      {
         bytes.writeEventId(engine.timeline.time,BattleLogEventInputAuto.index);
         BattleLogEventInputAuto.write(bytes,param1.direction > 0);
      }
      
      public function timesUp(param1:Team, param2:Team) : void
      {
         bytes.writeEventId(engine.timeline.time,BattleLogEventTimesUp.index);
         BattleLogEventTimesUp.write(bytes,param1,param2);
      }
      
      public function teamInput(param1:Team, param2:int) : void
      {
         bytes.writeEventId(engine.timeline.time,BattleLogEventTeamInput.index);
         BattleLogEventTeamInput.write(bytes,param1.direction > 0,param2);
      }
      
      public function teamEmpty(param1:Team) : void
      {
         bytes.writeEventId(engine.timeline.time,BattleLogEventTeamEmpty.index);
         BattleLogEventTeamEmpty.write(bytes,param1.direction > 0);
      }
      
      public function logString(param1:String) : void
      {
         bytes.writeEventId(engine.timeline.time,BattleLogEventString.index);
         BattleLogEventString.write(bytes,param1);
      }
      
      public function heroUltImmediateInterrupting(param1:Hero) : void
      {
         bytes.writeEventId(engine.timeline.time,BattleLogEventHeroUltImmediateInterrupting.index);
         BattleLogEventHeroUltImmediateInterrupting.write(bytes,param1);
      }
      
      public function heroUltImmediate(param1:Hero) : void
      {
         bytes.writeEventId(engine.timeline.time,BattleLogEventHeroUltImmediate.index);
         BattleLogEventHeroUltImmediate.write(bytes,param1);
      }
      
      public function heroUlt(param1:Hero) : void
      {
         bytes.writeEventId(engine.timeline.time,BattleLogEventHeroUlt.index);
         BattleLogEventHeroUlt.write(bytes,param1);
      }
      
      public function heroSkillCast(param1:Hero, param2:SkillCast) : void
      {
         bytes.writeEventId(engine.timeline.time,BattleLogEventHeroSkillCast.index);
         BattleLogEventHeroSkillCast.write(bytes,param1,param2);
      }
      
      public function heroMove(param1:BattleBody, param2:Number, param3:Number) : void
      {
         if(param1.isHero)
         {
            bytes.writeEventId(engine.timeline.time,BattleLogEventHeroMove.index);
            BattleLogEventHeroMove.write(bytes,param1,param2,param3);
         }
      }
      
      public function heroInput(param1:Hero) : void
      {
         bytes.writeEventId(engine.timeline.time,BattleLogEventHeroInput.index);
         BattleLogEventHeroInput.write(bytes,param1);
      }
      
      public function heroHp(param1:Hero, param2:Number, param3:Number) : void
      {
         bytes.writeEventId(engine.timeline.time,BattleLogEventHeroHp.index);
         BattleLogEventHeroHp.write(bytes,param1,int(param2),int(param3));
      }
      
      public function heroEnergy(param1:Hero, param2:Number, param3:Number) : void
      {
         bytes.writeEventId(engine.timeline.time,BattleLogEventHeroEnergy.index);
         BattleLogEventHeroEnergy.write(bytes,param1,int(param2),int(param3));
      }
      
      public function heroEffectRemove(param1:Hero, param2:Effect) : void
      {
         bytes.writeEventId(engine.timeline.time,BattleLogEventHeroEffectRemove.index);
         BattleLogEventHeroEffectRemove.write(bytes,param1,param2);
      }
      
      public function heroEffect(param1:Hero, param2:Effect) : void
      {
         bytes.writeEventId(engine.timeline.time,BattleLogEventHeroEffect.index);
         BattleLogEventHeroEffect.write(bytes,param1,param2);
      }
      
      public function heroDead(param1:Hero) : void
      {
         bytes.writeEventId(engine.timeline.time,BattleLogEventHeroDead.index);
         BattleLogEventHeroDead.write(bytes,param1);
      }
      
      public function getLog() : String
      {
         return bytes.getEncodedString();
      }
      
      public function damageEvent(param1:DamageValue) : void
      {
         bytes.writeEventId(engine.timeline.time,BattleLogEventHeroDamageEvent.index);
         BattleLogEventHeroDamageEvent.write(bytes,param1);
      }
      
      public function damage(param1:DamageValue) : void
      {
         bytes.writeEventId(engine.timeline.time,BattleLogEventHeroDamage.index);
         BattleLogEventHeroDamage.write(bytes,param1.source.hero,param1.source.skill.tier,param1.currentTarget,param1.resultValue,param1.sourceValue,param1.type);
      }
      
      public function customHeroInput(param1:Hero, param2:int) : void
      {
         bytes.writeEventId(engine.timeline.time,BattleLogEventCustomHeroInput.index);
         BattleLogEventCustomHeroInput.write(bytes,param1,param2);
      }
      
      public function clear() : void
      {
         bytes = new BattleLogWriter();
      }
      
      public function absorb(param1:SkillCast, param2:SkillCast, param3:int) : void
      {
         bytes.writeEventId(engine.timeline.time,BattleLogEventHeroAbsorb.index);
         BattleLogEventHeroAbsorb.write(bytes,param1.hero,param1.skill.tier,param2.hero,param2.skill.tier,param3);
      }
   }
}
