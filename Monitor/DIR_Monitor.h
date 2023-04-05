#ifndef TLC_TEST_DIR_MONITOR_H
#define TLC_TEST_DIR_MONITOR_H
#include "../Interface/Interface.h"
#include "../Utils/Common.h"
#include "../Utils/ScoreBoard.h"
#include "../Monitor/Tool.h"

namespace DIR_monitor{

  // shift bits
  static uint8_t L2_bit[4] = {8,6,17,15};//set,slice,self tag,client tag
  static uint8_t L3_bit[4] = {8,6,20,19};

  enum{
    set_index = 0,
    slice_index,
    self_tag_index,
    client_tag_index,
  };
  enum{
    SELF = true,
    CLIENT = false,
    DIR = 0,
    TAG = 1,
  };
  enum{
    N_WAY = 8,
  };


//core 0 L2DIR: [100] selfDir: [set][slice][way] self [TT] client [B] [B] 
//core 0 L2DIR: [100] selfDir: [set][slice][way] tag: [tag]
//clientDir: addr: 400 [B] [B] 
using namespace std;

class Dir_InfoEntry{
  private:    
    string title;
    string self_dir;
    string client_dir;
    string dir_tag;
  public:
    string all;

    string core;
    string mod;
    string cycle;

    string set;
    string slice;
    string way;
    string tag;

    string self_state;
    string selfclient0;
    string selfclient1;

    string client0;
    string client1;
    
    string add_title(uint8_t module, uint64_t Cycles){
        //Sorting
        cycle = to_string(Cycles);
        switch (module)
        {
        case 0:core = "0"; mod = "L2"; break;
        case 1:core = "1"; mod = "L2"; break;
        case 2:core = "-"; mod = "L3"; break;//L3
        default:core = "error";break;
        }
        //add
        title = "";
        return title = "core " + core + " " + mod + "DIR: [" +  cycle + "] ";
    }
    string add_self(){
        self_dir = "";
        return self_dir =  "selfDir: [" + set + "] [" + slice + "] [" + way + "] self [" + self_state + "] client [" + selfclient0+ "] [" + selfclient1 + "] "; 
    }
    string add_client(){
        client_dir = "";
        return client_dir = "clientDir: [" + set + "] [" + slice + "] [" + way + "] client [" + client0 + "] [" + client1 + "] "; 
    }
    string add_tag(bool dir){
        dir_tag = "";
        if(dir){
          dir_tag = "selfTAG: ";
        }else{
          dir_tag = "clientTAG: ";
        }
        return dir_tag = dir_tag + "[" + set + "] [" + slice + "] [" + way + "] tag [" + tag + "] " ;
    }
 
};


class Dir_key{
  public:
  paddr_t set;
  paddr_t slice;
  uint8_t way;

  bool operator<(const Dir_key& key)const {
        if(this->set == key.set){
          if(this->slice == key.slice){
            return this->way < key.way;
          }else{
            return this->slice < key.slice;
          }
        }else{
          return this->set < key.set;
        }
  }
};

class Dir_Mes{
  public:
  uint8_t self;
  uint8_t client[2];
};

class check_pool{
  private:
    // TODO:
    // This is a risky operation because 
    // Other operations within max_cycle 
    // may also rewrite the DIR
    const uint64_t max_cycle = 10;
    std::map<Dir_key,uint64_t> key_pool;
  public:

    void add_check(Dir_key key){
      key_pool.insert({key,max_cycle});
      printf("check cycle: %ld\n",key_pool[key]);
    }

    bool erase_check(Dir_key key){
      if(key_pool.count(key) > 0){
        key_pool.erase(key);
        return true;
      }
      return false;
    }

    void check_time_out(void){
      if(key_pool.size() > 0){
        for (auto it = key_pool.begin(); it != key_pool.end(); it++) {
          if(it->second == 0){
            tlc_assert(false, "no tag!");
          }
          key_pool[it->first] = key_pool[it->first]-1;
        }
      } 
    }
};



using namespace tl_interface;
class DIR_Monitor{
private:
  uint64_t* cycle;
  std::shared_ptr<DIRInfo> info;
  Dir_InfoEntry print;
  //self
  ScoreBoard<Dir_key,Dir_Mes> *Self_Dir_Storage;//2*L2 + L3;
  ScoreBoard<Dir_key,paddr_t> *Self_Dir_Tag_Storage;//2*L2 + L3;
  check_pool Self_tag_check_pool;
  bool self_write; // dir
  paddr_t self_write_addr;
  bool self_write_1; // tag
  paddr_t self_write_addr_1;
  //client
  ScoreBoard<Dir_key,Dir_Mes> *Client_Dir_Storage;//2*L2 + L3;
  ScoreBoard<Dir_key,paddr_t> *Client_Dir_Tag_Storage;//2*L2 + L3;
  check_pool Client_tag_check_pool;
  bool client_write; // dir
  paddr_t client_write_addr;
  bool client_write_1;// tag
  paddr_t client_write_addr_1;

public:
  uint64_t id;
  uint8_t bus_type;//6

  DIR_Monitor(ScoreBoard<Dir_key,Dir_Mes> *const selfDir, ScoreBoard<Dir_key,paddr_t> *const selfTag
              ,ScoreBoard<Dir_key,Dir_Mes> *const clientDir, ScoreBoard<Dir_key,paddr_t> *const clientTag
              ,uint64_t* c, uint64_t iid, uint8_t bt);
  std::shared_ptr<DIRInfo> get_info();

  //self
  void print_info();
  void fire_Self_DIR(uint8_t mod, paddr_t slice, uint8_t bit[4]);
  void print_Self_DIR(uint8_t mod, Dir_key key);
  void print_Self_DIR_TAG(uint8_t mod, Dir_key key);
  paddr_t self_be_write(void){if(self_write) return self_write_addr;else return 0x0;}
  paddr_t self_be_write_1(void){if(self_write_1) return self_write_addr_1;else return 0x0;}
  
  //client
  void fire_Client_DIR(uint8_t mod, paddr_t slice, uint8_t bit[4]);
  void print_Client_DIR(uint8_t mod, Dir_key key);
  void print_Client_DIR_TAG(uint8_t mod, Dir_key key);
  paddr_t client_be_write(void){if(client_write) return client_write_addr;else return 0x0;}
  paddr_t client_be_write_1(void){if(client_write_1) return client_write_addr_1;else return 0x0;}
};

}
#endif //TLC_TEST_DIR_MONITOR_H