package com.dsac.library.ejb.dao;

import com.dsac.library.ejb.model.Service;
import java.util.List;
import javax.ejb.Stateless;

@Stateless
public class ServiceService {
    
    private ServiceDAO serviceDAO = new ServiceDAO();
    
    public List<Service> getAllServices() {
        return serviceDAO.getAllServices();
    }
    
    public List<Service> getAllActiveServices() {
        return serviceDAO.getAllActiveServices();
    }
    
    public Service getServiceById(Integer serviceId) {
        return serviceDAO.getServiceById(serviceId);
    }
    
    public boolean createService(Service service) {
        return serviceDAO.createService(service);
    }
}