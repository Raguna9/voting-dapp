// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0; //versi solidity 

contract Voting { //membuat contract 

    struct Kandidat { //membuat struktur bernama kandidat yg menyimpan 3 data yaitu :
        uint id; //variabel yg menampung nomor id kandidat
        string nama; //variabel yg menampung nama kandidat
        uint jumlahVote; //variabel yg menampung jumlah vote
    }

    //membuat pointer untuk paraPemilih dengan key address dan value boolean
    mapping(address=>bool) public paraPemilih;
    //key address untuk mendapatkan alamat akun di jaringan local ethereum
    //value bool untuk mengembalikan nilai boolean berdasarkan key address 
    //(berfungsi untuk mendapat alamat pemilih dan cek alamat apakah sudah voting atau belum)

    //membuat pointer untuk paraKandidat dengan key uint dan value Kandidat dari struktur Kandidat
    mapping(uint=>Kandidat) public paraKandidat;
    //key uint untuk mendapatkan kandidatID dari struktur kandidat
    //value kandidat untuk mengembalikan isi struktur Kandidat berdasarkan key kandidatId
    //(berfungsi untuk menampilkan pilihan kandidat berdasarkan kandidatId)

    uint public jumlahKandidat; //variabel yg menampung jumlah kandidat
    
    //constructor dipanggil saat contract pertama kali di deploy
    constructor() {
        tambahKandidat("Kandidat 1"); //memanggil fungsi tambahKandidat kemudian mengisi nama kandidat 1 sebagai parameter
        tambahKandidat("Kandidat 2");
    }      

    //membuat fungsi private tambahKandidat dengan parameter string memory _nama (memory berfungsi untuk menyimpan sementara parameter _nama selama program dieksekusi)
    function tambahKandidat(string memory _nama) private { //fungsi untuk menambah kandidat
        jumlahKandidat++; //menjalankan increment pada jumlahKandidat dengan nilai awal 1

        //memanggil mapping paraKandidat dengan index jumlahKandidat 
        //untuk set struktur Kandidat dengan (id = jumlahKandidat), (nama = _nama), dan (jumlahVote = 0)
        paraKandidat[jumlahKandidat] = Kandidat(jumlahKandidat, _nama, 0);
    }

    //membuat fungsi public vote dengan parameter uint _kandidatId
    function vote(uint _kandidatId) public {//fungsi untuk melakukan vote 

        require(!paraPemilih[msg.sender]); 
        //require berfungsi untuk cek kondisi apakah bernilai true atau false
        //jika true maka code akan dilanjutkan kebawah jika false maka akan dikembalikan
        //code ini berfungsi untuk mengkonfirmasi transaksi dari address kita ke address payable(msg.sender)
        //jika kita konfirmasikan maka code akan lanjut kebawah, jika tidak code akan di kembalikan

        require(_kandidatId > 0 && _kandidatId <= jumlahKandidat);
        //code ini berfungsi untuk cek apakah _kandidatId > 0 && _kandidatId <= jumlahKandidat, jika true maka code dilanjutkan


        paraPemilih[msg.sender] = true; 
        //code ini berfungsi untuk menandai paraPemilih sebagai true
        //artinya vote hanya bisa dilakukan sekali saja per address, karena setelah berhasil vote address akan ditandai
        
        paraKandidat[_kandidatId].jumlahVote++; 
        //code ini berfungsi untuk menambah jumlah vote pada kandidat yang dipilih paraPemilih melalui _kandidatId
    }
}