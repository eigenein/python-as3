package com.progrestar.common.social
{
   public class NetworkUid
   {
      
      public static const FACEBOOK:uint = 2;
      
      public static const IGOOGLE:uint = 7;
      
      public static const INTERNAL_USER:uint = 2147483647;
      
      public static const YAHOO:uint = 5;
      
      public static const BEBO:uint = 4;
      
      public static const NETLOG:uint = 6;
      
      public static const MYSPACE:uint = 3;
       
      
      private var _networkUid:String;
      
      private var _intUid:uint;
      
      private var _network:uint;
      
      public function NetworkUid(param1:uint, param2:String, param3:uint)
      {
         super();
         this._network = param1;
         this._networkUid = param2;
         this._intUid = param3;
      }
      
      public static function areEqual(param1:NetworkUid, param2:NetworkUid) : Boolean
      {
         return param1._network == param2._network && param1._networkUid == param2._networkUid;
      }
      
      public static function create(param1:uint, param2:String) : NetworkUid
      {
         return new NetworkUid(param1,param2,0);
      }
      
      public function get intUid() : uint
      {
         return this._intUid;
      }
      
      public function get networkUid() : String
      {
         return this._networkUid;
      }
      
      public function toString() : String
      {
         return this._network + ":" + this._networkUid;
      }
      
      public function get network() : uint
      {
         return this._network;
      }
      
      public function get seed() : uint
      {
         var _loc2_:* = 1480002569 + this._network * 3571;
         var _loc1_:* = 0;
         while(_loc1_ < this._networkUid.length)
         {
            _loc2_ = _loc2_ * 23 + this._networkUid.charCodeAt(_loc1_);
            _loc1_ = Number(_loc1_ + 1);
         }
         return _loc2_;
      }
   }
}
