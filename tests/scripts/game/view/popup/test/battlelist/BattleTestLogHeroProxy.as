package game.view.popup.test.battlelist
{
   import battle.DamageValue;
   import battle.proxy.empty.EmptyHeroProxy;
   import battle.proxy.idents.HeroAnimationIdent;
   import battle.proxy.idents.SwitchHeroAssetIdent;
   import battle.skills.SkillCast;
   
   public class BattleTestLogHeroProxy extends EmptyHeroProxy
   {
      
      public static const ACTION_PARAMS_COUNT:Vector.<int> = new Vector.<int>(0);
      
      public static const ACTION_NAMES:Vector.<String> = new Vector.<String>(0);
      
      {
         reg("hp",1);
         reg("energy",1);
         reg("damage",1);
         reg("heal",1);
         reg("die",0);
         reg("energyBurn",1);
         reg("energyBlocked",1);
         reg("energyGenerated",1);
         reg("ultAnimation",1);
         reg("setAnimation",2);
         reg("stopAnimation",2);
         reg("setWeaponRotation",4);
         reg("setAsset",1);
         reg("setYPosition",1);
      }
      
      private var sceneLog:BattleTestLogSceneProxy;
      
      private var _id:int = 0;
      
      public function BattleTestLogHeroProxy(param1:BattleTestLogSceneProxy, param2:int)
      {
         super();
         this.sceneLog = param1;
         this._id = param2;
      }
      
      private static function reg(param1:String, param2:int) : void
      {
         ACTION_NAMES.push(param1);
         ACTION_PARAMS_COUNT.push(param2);
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      override public function onHpModify(param1:Number) : void
      {
         sceneLog.log(this,0,param1);
      }
      
      override public function onEnergyModify(param1:Number) : void
      {
         sceneLog.log(this,1,param1);
      }
      
      override public function onTakeDamage(param1:DamageValue) : void
      {
         sceneLog.log(this,2,param1.resultValue);
      }
      
      override public function onTakeHeal(param1:Number) : void
      {
         sceneLog.log(this,3,param1);
      }
      
      override public function onDie() : void
      {
         sceneLog.log(this,4);
      }
      
      override public function energyBurned(param1:int) : void
      {
         sceneLog.log(this,5,param1);
      }
      
      override public function energyBlocked(param1:int) : void
      {
         sceneLog.log(this,6,param1);
      }
      
      override public function energyGenerated(param1:int) : void
      {
         sceneLog.log(this,7,param1);
      }
      
      override public function ultAnimation(param1:SkillCast) : void
      {
         sceneLog.log(this,8,param1.skill.tier);
      }
      
      override public function setAnimation(param1:HeroAnimationIdent, param2:String) : void
      {
         sceneLog.log(this,9,param1.name,!!param2?param2:0);
      }
      
      override public function stopAnimation(param1:HeroAnimationIdent, param2:Boolean) : void
      {
         sceneLog.log(this,10,param1.name,!!param2?1:0);
      }
      
      override public function setWeaponRotation(param1:Number, param2:Number, param3:int, param4:Number) : void
      {
         sceneLog.log(this,11,param1,param2,param3,param4);
      }
      
      override public function setAsset(param1:SwitchHeroAssetIdent, param2:Boolean = false) : void
      {
         sceneLog.log(this,12,param2);
      }
      
      override public function setYPosition(param1:Number) : void
      {
         sceneLog.log(this,13,param1);
      }
   }
}
